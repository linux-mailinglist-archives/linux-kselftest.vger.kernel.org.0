Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC972F28E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 04:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjFNCXc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 22:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFNCXc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 22:23:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B0F1A7;
        Tue, 13 Jun 2023 19:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghCT8DtZ/z3ycCV45OLsbuxSPb4S6naAGpPcyXGBfiUaGBCmmq9g8aqBsAYKDJHLkvllyOaXkvN47TFhe5tMT4ALyHUe4zSieCuyhXp/bu9R9pN80FCm+CPzMI0U/rajGHQAbcC/CPxrku3waOdNAFORQOAI8IK8pZ4Yfmjz0mQjhhcIOTuK5wjb21LbDcLajztPDEp/hqarxfxrYFiuOd4G4LDU1aBEC1uzecOoY5IL/lBhCKsAl4VuChwMFHFVIK9zEIHhirCSkFVaOjbKwp25fsDL2Xdh0/PKkoo5QsehUGkXGyAcZhf0XzfbsQs/n6YyyL1l4aIZJZ6u6YJhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbMYr7BNh7+hho3v2ve7qP3OgkaYtSHa4bsm0O0w/Y0=;
 b=BNgmtuq0vc7qzbf7Hx/PriYokIYpqlITcrCA/AvuSNTQF7CsehtkACrUafWkThdpfusaQQk0Ln68RFR87faM1zvxXPfTXTNjnvvSrO7tE2AOVTSbC/j41fL5aMBiav9BdSppdupejI1Zk3KX5QmH2uPIJQKXmZ/bdVD4PoX8TPwNmdyl9uWBg+jtcdeOpd7RO5eopHazePrzIzl3pLkNKYH11QtQiRyd709nCXzSrWWzJBdXx8QEib8AlZwOIv/8njX7jtKLSpRlQSGZBGDEbGuz/qhWAYW24gYl51MsGlmSFiyHf8c3KVnlhF4GUjMxiL+JT1flVNgZSlciZvfmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbMYr7BNh7+hho3v2ve7qP3OgkaYtSHa4bsm0O0w/Y0=;
 b=HDxssCQTk5H3wF+lqKsMmf0CGYL/xQL8gx3HJWPABfYshzi1VQV/m9UHJOuNWkN6QRFFgTjJX+BeakZnOAAoyY9sw7Dqewt9TMHz/VMHRydljgfXt/yBZvmNd3tBle18YOuwdS3GSzao+iU+TywLq8Id0fdDD4ehjd09gQU+9CvoTLXDgw+9Qvv9P+lLEPgNdo9uJuZQpMxeYyEermRa2KwpzZdcw7hqq2FkMbTX4h7Hq8wZkyXPFGwCp92r4/UC9AtBwOC70WbSQn4xMtxrN9G03kWHn1gjUf0iQr1StE9rRVa9AUCnnfSCzXoQ56iR/5Hcuk9ubcE+U6Bkl5WUPQ==
Received: from DM6PR11CA0010.namprd11.prod.outlook.com (2603:10b6:5:190::23)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:23:27 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::ce) by DM6PR11CA0010.outlook.office365.com
 (2603:10b6:5:190::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Wed, 14 Jun 2023 02:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.23 via Frontend Transport; Wed, 14 Jun 2023 02:23:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 13 Jun 2023
 19:23:21 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 13 Jun
 2023 19:23:21 -0700
Message-ID: <928ad485-2dc2-2e02-98a2-fa203441f463@nvidia.com>
Date:   Tue, 13 Jun 2023 19:23:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests: lib.mk: fix out-of-tree builds
To:     Anders Roxell <anders.roxell@linaro.org>, <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <usama.anjum@collabora.com>
References: <20230613074931.666966-1-anders.roxell@linaro.org>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230613074931.666966-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 88593080-ec88-47fb-96e0-08db6c7e5682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLQKT67JuXVF+II4vnZqI5r3H4BKChZN8kZSNErx9xPYZaqz4Z0bifkaX7QfUHnt7/Mxopgm2CtAp5pVymCVbT0/+8dytdlfaNqh7IY8GpYcjaOs401ncRo+jqL4Zih7YPa8Bi+/12IjRW8PppeDSh0gJIV9jn5V/YYxFmMeQsCGpNXaYnTxUzb3GMVBn/ZeVpFeBaAf8LG64qibXvObGx64+2RHLfL/GkV9gbKjXISieHt9Fr7APKzLwYP8nn11neBWFtSlZhdDBRiQYnMNx4yjMazolcyvtL7xBbUfCNHkdX5GbR8fS5k4BEheeF1LQ6zE2Z4n2wtsFRETC+sMbIrW244KDK7aha7dx6b/ax1Fd1cfbqrPRosM2yME4IMC3O8crLm6XKqQic+EkQPUchlTf0Ol4VIhohCRxnzww2I18TGRBfbA4yhIXrvrEMmg/AZ3iDRFbwdx6KjHppoQKFLMPHpe/rq+FZDewifZl8cNTY7s5mBN25lHBQnsSDQzN1laMd4bOxnqt5iZLy2UasdzlWQzhU5+cF+Z808KuiA4+Y9N5sKksHwugyUXtKr7bLUmu/w6fMxUJhkECDfMf+emSQ8q3LbpPtByBk9iBopIvVNjJXgiR7HCYnFyE2m5n2uEnKKtmaxWoWPLeU/EKFLsH59xM4ew25i7Rgwsh5wS0vuB6hFgVo3uX712aEwb7lpWYX2JkWAWo+6rkncsaaq04+SSITtidFi4gjCVWL+wbwmGEOtnj8V+1UP6n1+rBnMPeGZDGBgeekoHIQaa5Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(47076005)(31686004)(70206006)(70586007)(4326008)(426003)(336012)(36756003)(16526019)(186003)(54906003)(478600001)(110136005)(2616005)(16576012)(2906002)(8676002)(316002)(41300700001)(31696002)(82310400005)(86362001)(40460700003)(36860700001)(356005)(53546011)(7636003)(8936002)(83380400001)(82740400003)(26005)(5660300002)(40480700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:23:27.4572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88593080-ec88-47fb-96e0-08db6c7e5682
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/13/23 00:49, Anders Roxell wrote:
> Since commit ("selftests: error out if kernel header files are not yet
> built") got merged, the kselftest build correctly because the
> KBUILD_OUTPUT isn't set when building out-of-tree and specifying 'O='
> This is the error message that pops up.
> 
> make --silent --keep-going --jobs=32 O=/home/anders/.cache/tuxmake/builds/1482/build INSTALL_PATH=/home/anders/.cache/tuxmake/builds/1482/build/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- V=1 CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install
> make[3]: Entering directory '/home/anders/src/kernel/next/tools/testing/selftests/alsa'
> 
> -e [1;31merror[0m: missing kernel header files.
> Please run this and try again:
> 
>      cd /home/anders/src/kernel/next/tools/testing/selftests/../../..
>      make headers
> 
> make[3]: Leaving directory '/home/anders/src/kernel/next/tools/testing/selftests/alsa'
> make[3]: *** [../lib.mk:77: kernel_header_files] Error 1
> 
> Fixing the issue by assigning KBUILD_OUTPUT the same way how its done in
> kselftest's Makefile. By adding 'KBUILD_OUTPUT := $(O)' 'if $(origin O)'
> is set to 'command line'. This will set the the BUILD dir to
> KBUILD_OUTPUT/kselftest when doing out-of-tree builds which makes them
> in its own separete output directory.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   tools/testing/selftests/lib.mk | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index b8ea03b9a015..d17854285f2b 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -44,6 +44,10 @@ endif
>   selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>   top_srcdir = $(selfdir)/../../..
>   
> +ifeq ("$(origin O)", "command line")
> +  KBUILD_OUTPUT := $(O)
> +endif
> +

Thanks for fixing this up! This looks correct.

(It's too bad that we have all this duplication between the Makefile
and lib.mk.)

thanks,
-- 
John Hubbard
NVIDIA

>   ifneq ($(KBUILD_OUTPUT),)
>     # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
>     # expand a shell special character '~'. We use a somewhat tedious way here.


