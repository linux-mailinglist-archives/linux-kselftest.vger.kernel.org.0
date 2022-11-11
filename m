Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1715625863
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 11:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiKKKcL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 05:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiKKKbf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 05:31:35 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29862BA7
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 02:31:30 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=JV92BRYvkHZ3/OZ8yRyaW1CaWGMMTQpNuSI1aslgKN1qnZFmRNRR+uhiWZ66u+fkQQQ6ooxwH1hqyZG5HGXPFJGB0OQ2Od6u4WScHm+2kVEpTeHpDu/xA+7AdrQ+Ed5T5E50DGBgmQZ1lkorOCM5ZeV2w6nltop6Bnqb8wosGFpQtdPpJcOiD3Dr4u3Q0d93Lvs7xrz8bBi8IhSuLOgKwunJOKl+vEUj3nUD3QRfBxSueOw65pWqwkaTET8HiCAalh0GPhLPCqU7UyQCZNlX6NTkfasL8qZWtuQPIufDu9JX49B/aMN1OtlhvRnokNlIwov1zB86Dno954K+S0Vnkg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HF1bvkIiMoqzLqIj8eVpYWq2jELwD+VCf9KXsaoSuk=;
 b=Ch8dbbsKWjl3RlabX5EnFKSTWDAHO/jyk8pi5NOxc6fXsjqVQlchYpwFCR/dV+Ldj3U9+UWLuDu+9ojE47T5AYxleJaOvnKfsQG+yNdye3J5QKCfDOVmxIWrTTgObcKIWfIg++o97BF3LDH9bw5bckJhhIGY6bWxE+ofHZ3jV8ESjRxr24SjUaXOmBWi3RBJv3zXrwl6uzSQh4eKfnyXit0mjzyPf5yKtizl4KdhEF+cck7Q1S1T6rLHbzb3CWrRRLCKRDRB6dbforNUOPwIkPO2/XHTiqrDkU61EJvDvMTkf8U7ccZ1kd14ybkuakXQmrb8e5zWlNFE5a0oB4Yu5Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HF1bvkIiMoqzLqIj8eVpYWq2jELwD+VCf9KXsaoSuk=;
 b=PXv6wnXwbw0Qlofaa4lQfeVGpkXlgoTt8YFUwtf71lyy3wJ3EKgAwxd6hpifX+ktKDQYZpoUyt92c0NDd7YPtHE41TEpGDe0XbP6Yq2ZP0cXEjQGy9v596dAYnfh292UMSWyOvi9khwmMw+kDr8aJCoC1der7FQTVxMqRn/7KiQ=
Received: from AS9PR07CA0047.eurprd07.prod.outlook.com (2603:10a6:20b:46b::23)
 by DU2PR08MB10129.eurprd08.prod.outlook.com (2603:10a6:10:492::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 10:31:20 +0000
Received: from VI1EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:46b:cafe::a9) by AS9PR07CA0047.outlook.office365.com
 (2603:10a6:20b:46b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Fri, 11 Nov 2022 10:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT028.mail.protection.outlook.com (100.127.144.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 10:31:19 +0000
Received: ("Tessian outbound aeae1c7b66fd:v130"); Fri, 11 Nov 2022 10:31:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f1caa010af60b38a
X-CR-MTA-TID: 64aa7808
Received: from 7418017a3933.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B55D218A-8DAE-443C-B2DA-48550A06CACC.1;
        Fri, 11 Nov 2022 10:31:12 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7418017a3933.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Nov 2022 10:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvTUmU2OOzs4xTSHoQsyFx2tAgKgLe/tvqAwr7MFKYOSMu4ONSBRJ5bwwZISXaHwzBasxNPQpxQeR9ZsWKdAIg2UBeMcS4e9xNs/3sicH0Uo54/fPlkSClLBG36bCzNASEEbRJrXebY/y7OURXi4Wc8SxcLPPDQwDD18rki5Iy2v66ZwMa+WwC3MtaoSOs8so2YSJpYMd5s9e+egw9C+vB/BiGmO6SB1lqeE5kY6IRuogNIBn+gOCm5dpUa9stuEZCJunqggDa25vWNVsUXIrcro6v8OhzbfVIF+ACw4jFqG++6z2er/kEyRio79DX0JZKjoqvNkKKSZipI3zP1fRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HF1bvkIiMoqzLqIj8eVpYWq2jELwD+VCf9KXsaoSuk=;
 b=Rlo4hqHUiMRv7Xbv+xcac+FRXSAcXmznQkhs+Z1djVhspbwWkfvpeN+HzWFdvbQdkbqahLQxsEL3Kz9TJ11KRRBqEWbCFizcsIf44Rm5TyR2FNqDl6iDuYWineoXD6yXyk/u+NSlYoTovwtqp8EtQvd5FFgSgo0IuYteJKZkXeR3cviF/peoScYta9Hh76WNWDU8LSS8tcZi5GYNG39Ybd/YQ6mPBmLaQkASusReQZkBn2iTPt6ctvUQIGLMt1m8MnUrleuhwwiCmEWq/VuJQWaedYu0FLnRXpoKZ5jDdjt+k+F79Ei1bwNdxqe6zOVUvjnVmwZf//iHqv3r9HdBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HF1bvkIiMoqzLqIj8eVpYWq2jELwD+VCf9KXsaoSuk=;
 b=PXv6wnXwbw0Qlofaa4lQfeVGpkXlgoTt8YFUwtf71lyy3wJ3EKgAwxd6hpifX+ktKDQYZpoUyt92c0NDd7YPtHE41TEpGDe0XbP6Yq2ZP0cXEjQGy9v596dAYnfh292UMSWyOvi9khwmMw+kDr8aJCoC1der7FQTVxMqRn/7KiQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by DB3PR08MB8962.eurprd08.prod.outlook.com (2603:10a6:10:43f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.11; Fri, 11 Nov
 2022 10:31:10 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::f9e6:599b:e673:801]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::f9e6:599b:e673:801%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 10:31:10 +0000
Message-ID: <5d832654-c196-2c6d-9bb1-61feb2a81fb4@arm.com>
Date:   Fri, 11 Nov 2022 10:31:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 12/21] arm64/sme: Implement ZT0 ptrace support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@foss.arm.com>
References: <20221101143336.254445-1-broonie@kernel.org>
 <20221101143336.254445-13-broonie@kernel.org>
From:   Luis Machado <luis.machado@arm.com>
In-Reply-To: <20221101143336.254445-13-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::34) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI1PR08MB3919:EE_|DB3PR08MB8962:EE_|VI1EUR03FT028:EE_|DU2PR08MB10129:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7416e5-ece3-4717-5df9-08dac3cfdf2a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wkbLoWn7zh1yZ9qcgNiXLwlHtNEk6F60/tlTAFRkpU7DMlycKtp8kQ/QE73MuhMSGQAo0KSZBjU9e3VFLH6OLCANeGkDk6TRyqN5S25yo3U54HZFryc0mPf3n3ByS2ZjwnejQ326z5+eg14DakGSlGFrEBuuvYUID8rB3EfYiF0LptxJeCLr0gQk1Ez9fgnsPJlmB8rLf/Y5BoS0UvghyJcmZbGb5tt63FksPtayCszPcwASEgktNN9tFUTKJTHHXtLzAVCxSh7W/OFHeKzcobyMROqDpSMuY3jJvQceJud4Ex4UkWeXMUVE+HvHhsuatx0WsLmkczxvbLc0Di8UX97qu/oChmeABdH3y1u9Uju277D1TC0lf504Oyevsi6isWElfIu5XQLak3DiVWIFrbaijoP1zbQo1pdJTURmeRPqAdsvZn1jJxNMPoDX0P65MiY4okjj2wu6z5c4fXD4hiFvvgdEAlCkqutq7i1rF/qsruOsKQUltv1ikpyPDzYKfAAaCdKpOkqW73jlcd/sX/quq2MOzyIWqO+ah0wlSh55USXe5hVv+fjsvLb4EA48rxxSVSOjqJaRcE6nOaUTVrTatPX/1bKK8wGgqLPehIWfc5phZ8Kb7Jc06x2cm+ZVCgr5XCW+fOMbtyv60pZh6D5Hj8wBkZbAVcSltwcK0pxMNG1loq3jzLzBBan+X1b43jEjORrPDSE8SQP/BWzw7t7ZPKgNr3BtGY+FLkuey+7XZDMDGieHiqETcBxIOQ2ovqxWp0qaUnI+J6GgZO3+f87avauK9Ge54jsWtekDhEU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(31686004)(36756003)(54906003)(38100700002)(86362001)(110136005)(6512007)(6486002)(316002)(6666004)(31696002)(66946007)(2906002)(6506007)(478600001)(5660300002)(53546011)(83380400001)(4326008)(2616005)(8936002)(41300700001)(66556008)(66476007)(26005)(44832011)(8676002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8962
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 51ff2b5a-7582-49c7-3528-08dac3cfd995
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aC/XamOAYrmFcCzeDXrpVQ4YM1Ejhva+bsWQPBUMDA6VTdl662Bxu3bi0CMt7Qf7iIGk4EnDBEAGPPY/PCyAbatN2LjIc7nYqHO6r7P4C2YxMNboIkGPc27OeVPRaci9hKOJ4MTGqKmgt7rpNu22uCn/B4cNCwEX0BuS1GOVYLKIU9IwoS4R4GxREWY8282AHmSjPY5Y98XF3JI3PXCaCal7yGWmXPaSx+wf7/HYaKPAWpd2nl3n251pxQGgEEATrlXqGmwfAyCo2kqq0N2DJCCB0cOa4LFhR76s1H1e8eHxmAxkLy6DokKeYSPQq0LbCURJD7NpicS1jPNc4ipXrztG2y/1YOPGDcTZ2QlFxVu+ae/uNJwC2RtrsGJw7zI7HMrft1/Uy6V7ppH3vB+T2E76JH9WvinOBOqaof4Ime0QzfvB90UH6p0cQW9B3Qcs521ylmONDSNVhElc0V2eR70XTZb9IONIqaPIXv36EfVeyIFA7UokU9VYGiR9PpCRgBJnHYSxrE8NrAP4/ujDky+H8+gCn0Ui4RuMlalEYopq6/mlOXnin8qoFj8nN+wVB8ID5jjmI5fjUxF3FWyvZ8EI/yFaIRl7iU73iOHKwjrGqF9+pyXcfJQ4pT4FBTDyBSGB5W73TQKOAoQxYyWllDmEXFz7PAPGWS5gCrYnGeJlWipTN1zUlVQjBYPqAd9vpd5x6f9aawyZEkpjkqix7XFVdHiRhw8LVxKgPQLd5cTHdXq9rTLRoON8RrxIeXNFYOAGU//2kT+Fm8pvaT/ieK5W8PPUxeLn3AC614ATgWogEimDmfr3DwKfl1Nvowj
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(81166007)(356005)(83380400001)(36756003)(31696002)(86362001)(40460700003)(40480700001)(316002)(82740400003)(54906003)(31686004)(110136005)(6506007)(53546011)(478600001)(6486002)(6666004)(41300700001)(186003)(5660300002)(336012)(2906002)(8936002)(44832011)(2616005)(47076005)(70586007)(6512007)(26005)(4326008)(70206006)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 10:31:19.4995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7416e5-ece3-4717-5df9-08dac3cfdf2a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10129
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/1/22 14:33, Mark Brown wrote:
> Implement support for a new note type NT_ARM64_ZT providing access to

Should we use NT_AARCH64_ZT instead? This would align with our previous choice of PT_AARCH64_MEMTAG_MTE.

And we have a precedent with PT_AARCH64_ARCHEXT as well.

> ZT0 when implemented. Since ZT0 is a register with constant size this is
> much simpler than for other SME state.
> 
> As ZT0 is only accessible when PSTATE.ZA is set writes to ZT0 cause
> PSTATE.ZA to be set, the main alternative would be to return -EBUSY in
> this case but this seemed more constructive. Practical users are also
> going to be working with ZA anyway and have some understanding of the
> state.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   arch/arm64/kernel/ptrace.c | 54 ++++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/elf.h   |  1 +
>   2 files changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 85105375bea5..a508f3a69d9f 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1145,6 +1145,51 @@ static int za_set(struct task_struct *target,
>   	return ret;
>   }
>   
> +static int zt_get(struct task_struct *target,
> +		  const struct user_regset *regset,
> +		  struct membuf to)
> +{
> +	if (!system_supports_sme2())
> +		return -EINVAL;
> +
> +	/*
> +	 * If PSTATE.ZA is not set then ZT will be zeroed when it is
> +	 * enabled so report the current register value as zero.
> +	 */
> +	if (thread_za_enabled(&target->thread))
> +		membuf_write(&to, thread_zt_state(&target->thread),
> +			     ZT_SIG_REG_BYTES);
> +	else
> +		membuf_zero(&to, ZT_SIG_REG_BYTES);
> +
> +	return 0;
> +}
> +
> +static int zt_set(struct task_struct *target,
> +		  const struct user_regset *regset,
> +		  unsigned int pos, unsigned int count,
> +		  const void *kbuf, const void __user *ubuf)
> +{
> +	int ret;
> +
> +	if (!system_supports_sme2())
> +		return -EINVAL;
> +
> +	if (!thread_za_enabled(&target->thread)) {
> +		sme_alloc(target);
> +		if (!target->thread.sme_state)
> +			return -ENOMEM;
> +	}
> +
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +				 thread_zt_state(&target->thread),
> +				 0, ZT_SIG_REG_BYTES);
> +	if (ret == 0)
> +		target->thread.svcr |= SVCR_ZA_MASK;
> +
> +	return ret;
> +}
> +
>   #endif /* CONFIG_ARM64_SME */
>   
>   #ifdef CONFIG_ARM64_PTR_AUTH
> @@ -1367,6 +1412,7 @@ enum aarch64_regset {
>   #ifdef CONFIG_ARM64_SVE
>   	REGSET_SSVE,
>   	REGSET_ZA,
> +	REGSET_ZT,
>   #endif
>   #ifdef CONFIG_ARM64_PTR_AUTH
>   	REGSET_PAC_MASK,
> @@ -1474,6 +1520,14 @@ static const struct user_regset aarch64_regsets[] = {
>   		.regset_get = za_get,
>   		.set = za_set,
>   	},
> +	[REGSET_ZT] = { /* SME ZA */
> +		.core_note_type = NT_ARM_ZT,
> +		.n = 1,
> +		.size = ZT_SIG_REG_BYTES,
> +		.align = sizeof(u64),
> +		.regset_get = zt_get,
> +		.set = zt_set,
> +	},
>   #endif
>   #ifdef CONFIG_ARM64_PTR_AUTH
>   	[REGSET_PAC_MASK] = {
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index c7b056af9ef0..3a73c853c537 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -434,6 +434,7 @@ typedef struct elf64_shdr {
>   #define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl()) */
>   #define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
>   #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
> +#define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */

I guess the above comment means this would also need to be NT_AARCH64_ZT, but historically we've been using NT_ARM_* even for AARCH64.

So I suppose this is OK.

>   #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
>   #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
>   #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */

