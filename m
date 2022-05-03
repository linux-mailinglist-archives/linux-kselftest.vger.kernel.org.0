Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688E7517F89
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 10:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiECIRL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 04:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiECIRK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 04:17:10 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28621808
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 01:13:38 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=QjaRGaQ1PZcOCU0v5wZy3417ZOarlIS+NCYZCmIDLb9+CDDM1dyO0SErS2qoE5PvdsGFv126mmpvNRWyXtLE8ZtZHzC6HXSLd/ZFLYtFJ0RyEBEotXkRIpYpmCQHdj9ztuFIS12DLqn4HQLs+PPKl7Lvo4sUD8VBeVTXtteEg3FgRCaVZwiDj2e2IoerLAb6fkQq3owSckdv9GjLq64T1wf0gs4kPOvU8owgau4a8l+ru+5YiUNsffefS7y1idyq6C57EKrNYn/U+6U1e+CoHkT6viKyctklL0keK/si2xQzn6BYAB3ny6B00jpcePpoCQRVns05MtFDCsYNny1rXw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12P3TpUwPZFrXtxik6iYyEVWFTiih5G83nj9vFeYXTs=;
 b=k/OaB1VTX00u1eYbhDZ39gtAhYE/1DigyjDloIDI3MmGJBuv3UQWt3sdq9tZvNWmS9hyeTblTxvnZmgBVvHAto4485e782+mEBmVO9YGqsL8ZH0sikW/Sipty5Y0EprsOEbutU5p47hUOrqunv/BKhLRouTkvo0ShT5CZgLThnGVd1TftdFiztnyCigfUiFPW80z4Y1NFEql6XDE4EWuDhFv11kBuoAIslWAFzT/eR9P9tADIYUvavvg3P2hy1Iy5cYXb1I2yFKKt0UjQuABnWNL3NkZgjiM/uyZcx8F8Np7JVzp2vcOFPfT/WQndcYKE3exDOMID+FEUS2UMHOvjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12P3TpUwPZFrXtxik6iYyEVWFTiih5G83nj9vFeYXTs=;
 b=oxLcyTNlUUZXOVmI3aGeXsdGDrD2enp+GkVHVZqqytfhSaZ9Q+sXyXVH3YzVFdSqLgf1XySxflfHgO5R7QtuWI84RDSL4xvWRMWv+eJSLuE/E20P3NCNxHhicfgxwLymLh5fgHU72GS6DL8smsvixMs7PmNNxibQ6poF2LBIvEY=
Received: from AM6P194CA0047.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::24)
 by PAXPR08MB6639.eurprd08.prod.outlook.com (2603:10a6:102:154::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 08:13:35 +0000
Received: from VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::50) by AM6P194CA0047.outlook.office365.com
 (2603:10a6:209:84::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 08:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT021.mail.protection.outlook.com (10.152.18.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 08:13:34 +0000
Received: ("Tessian outbound facaf1373bbd:v118"); Tue, 03 May 2022 08:13:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b02e5ef33f797400
X-CR-MTA-TID: 64aa7808
Received: from 8bf7a89e5314.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CEA04689-D191-4A71-9508-1BB37F29BDD8.1;
        Tue, 03 May 2022 08:13:27 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8bf7a89e5314.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 May 2022 08:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/4ms4zDht8g0p6y61Ye9jnEPZ/mJdogLUbGEbiHY+3rWDvX8y3U2Z634H9vY2JxnFZc6cLWmp8efM39icwfZm/QE/+21vRmGBMKGOBHxQxmSGHl4BDKfavdsPRzjLynTHDGQI7tZCQx/CGw5qyUtnml8DcfNx3vlzzqYIn1afG4Y/G/vy4N2jX6ftBVx54jKm1AbnX1hqxubaIde7z+QEL3Z4CkqsK2z2gGOdYu2JVsUSh/rtzfalgFcDGzEMK9GkQ4YINdSozR0YtvPA+AAnbYjtLsabmVnb7R2iVHHEw1a+d1nk7eiMEoHMbZlp6XD/a9QDi6s0Y3Zd4a/4gB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12P3TpUwPZFrXtxik6iYyEVWFTiih5G83nj9vFeYXTs=;
 b=mamvmsyF7qnaOQpWE2btRbHI00yfkn9J68aFnGBfIz224F9s3D2sVoDkOAk9ZMEwkjzUQ0p0WWlQ1pw6p8WrqUSO6N9e7VW2J7qOW+zUainz5TgOv3m1/LVMtWqU2OZkKClbpvxbc9RQJY9DzU+2hu9Wq5Ni8nz5crn9tPn1mac5RUkpXEYZdwRubm54zhHKW8IBnbayYuOGL3KgBRNne7BO0kYo+lTgBxFmX4HwWP1Zh+5AcdwXmaOQXgZ2O18mVlj7LqaMTblnkx4D4S+V2oeF6nJaDDhf0vwSV6WjEiIH6xUoCh8qGdXoJQi/iXjDGWY1uXG9KamQ3JcBMt3YcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12P3TpUwPZFrXtxik6iYyEVWFTiih5G83nj9vFeYXTs=;
 b=oxLcyTNlUUZXOVmI3aGeXsdGDrD2enp+GkVHVZqqytfhSaZ9Q+sXyXVH3YzVFdSqLgf1XySxflfHgO5R7QtuWI84RDSL4xvWRMWv+eJSLuE/E20P3NCNxHhicfgxwLymLh5fgHU72GS6DL8smsvixMs7PmNNxibQ6poF2LBIvEY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB7PR08MB3404.eurprd08.prod.outlook.com (2603:10a6:10:4c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Tue, 3 May
 2022 08:13:25 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::9ccc:fe7c:19e5:bfa6]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::9ccc:fe7c:19e5:bfa6%4]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 08:13:25 +0000
Date:   Tue, 3 May 2022 09:13:11 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v14 04/39] arm64/sme: Provide ABI documentation for SME
Message-ID: <YnDkF1cfR+cL18Gu@arm.com>
References: <20220419112247.711548-1-broonie@kernel.org>
 <20220419112247.711548-5-broonie@kernel.org>
 <YmpcGpSYpoiprngy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmpcGpSYpoiprngy@arm.com>
X-ClientProxiedBy: AM0PR04CA0048.eurprd04.prod.outlook.com
 (2603:10a6:208:1::25) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2802e33a-eefe-44a6-669a-08da2cdcd1af
X-MS-TrafficTypeDiagnostic: DB7PR08MB3404:EE_|VE1EUR03FT021:EE_|PAXPR08MB6639:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB663949373693670A0C16AEF5EDC09@PAXPR08MB6639.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yyHrF39+cYledTiMQLPD1KlKvPcVy06NoJp+8gX/OYoryZrYo5S3AUPELOULTHAKj504Nw1irZvwCo4NOJZ5z313VL6L/22rbYNbioEaLQmZ4wTTT2+LJvwiQiJIJMY0unEcddayOKIqshcypFHZeb+fRcWf2BGPPoee8qipVmJ8SOu/KQtdY+0UDrxyR59vpEi9Mh06BeOZIw9fq1t9/JcukIkQEPGuZrNUCLQAhCn5knDeuKSjbdCyGW7nSayAzXlE1l2egsH97RQE3RyoB25oW4/apuHdQZJL9sucX9sLvjO2tji01bG6xqtEy7qkh+OyIr4P+3eEEZfMoM1E2VfGRaBAcDqukdWULwHOURjWQ/+QQVA/TNQXCebd9y4QSTfzDfo1qU0X2Px9Jljq70NmDlAAMeiHeN8Nc+wM4AbscKl4GsT9MWvdO/+fgnpLpXJ28+hZksJ0GZDZEBmIcL9rYrA1yZ+rDkhVnFPwRHFkbe6JdBFL4A2lsfEatU5aIh5602u3/fLcfS8d/+eLQfbGJ3XcPJxIZ0zveOp8meQ65L5SU9sF/sfmmCsIPXvyLdX12We8viYY7LZWBfVUdgw7iLoE5OOpItCPT7jgydEYnjzQPGyTIIOwv81ETMcySbkRGsg65BoT1+1wzccCwlSINr6zY+4kFrWmW48QIAnqGb/8dIBDp0QAyJatccWkCmfhcraEidFy1vYpvUXgdA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(86362001)(6636002)(6512007)(26005)(66476007)(66946007)(4326008)(66556008)(6506007)(6862004)(8676002)(508600001)(316002)(6666004)(38100700002)(54906003)(36756003)(37006003)(2906002)(8936002)(5660300002)(2616005)(186003)(44832011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3404
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0a863e43-6aed-4b8f-0fda-08da2cdccc16
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgZssQT0kqB4aDJ1ByWe3B6K62Ejtwvkv1oWcrO7rDqGOLDHzb5bBFvJ/Qumhh9RSEZzTdrczvm2gsDLsd8U93U4dY6k+p/ode/bqNGSb8zT+wDIkb50lKEEfDGmwhGVy7Vi22nKBCnwZq7m30YENHd6CD80PdEMjArtqkDJLV4kDUEw7hmMr8Ed0NedIEmUH/C48ZykdqWTRH+Ji7ElGyvpV0NJfqvzWTXLoDP3+MVUB4TMhNPUSaFGzIMAABtYpaRXfcqVQ/f/8yoek+SMilbfWgSWdUEIV7xn8KG5gqxvxLfwPR/XgunxSSfOsxgsfgQsLZCAKW+duzs8VHyL8OwpoqmMaF86ZBnb3AUTAYa8qFogF+4K+DmEXcDQjNfdixCKoZeDs6zxccea387PKLntO9tE3IIDYt3wURp3NVre2NLD9TEre/aqWlw6OBbwm+hEaDCqh3etqYb68AOhOhRbr6UdjfBaoPvYzQPi+i8dq5mAAyp35JHdFDUy8IXeZqPU7YQZpGLhBLdPzqwjiKx+/pXzNvGIszqqNEqA+cKY8656RUml+LjRlNPJzZBdse7VT6STWW4wDf2/tccPcfAr9ShdG5mtIMia9V0w0AL5vO85baYMjp9N6cL1l2S1AVDMZ+dbeb8Ox/el1gUdlWuO0MbFwnqRyUZahgMa23h0DVIvGLfnqzTKF0jRPgwqPwrVVA2DDfejZF288i5VIg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(70206006)(6506007)(6512007)(6666004)(70586007)(6636002)(26005)(508600001)(40460700003)(37006003)(54906003)(6862004)(4326008)(6486002)(36860700001)(186003)(81166007)(356005)(2616005)(47076005)(336012)(107886003)(5660300002)(8936002)(2906002)(8676002)(82310400005)(44832011)(36756003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 08:13:34.7613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2802e33a-eefe-44a6-669a-08da2cdcd1af
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6639
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 04/28/2022 10:19, Catalin Marinas wrote:
> On Tue, Apr 19, 2022 at 12:22:12PM +0100, Mark Brown wrote:
> > +* There are a number of optional SME features, presence of these is reported
> > +  through AT_HWCAP2 through:
> > +
> > +	HWCAP2_SME_I16I64
> > +	HWCAP2_SME_F64F64
> > +	HWCAP2_SME_I8I32
> > +	HWCAP2_SME_F16F32
> > +	HWCAP2_SME_B16F32
> > +	HWCAP2_SME_F32F32
> > +	HWCAP2_SME_FA64
> 
> Marc pointed out that in combination with FEAT_WFxT, we used all the
> HWCAP2 bits (32). While we are ok for now, we'll soon need to look into
> what to do when the next features turn up. Some options:
> 
> 1. Only provide HWCAP2_SME and let the ID_AA64SMFR0_EL1 features be
>    probed via MRS emulation. It doesn't solve the problem but it buys us
>    a bit of time.
> 
> 2. Don't bother with any new HWCAPs, just rely on MRS emulation (we have
>    HWCAP_CPUID advertising this).
> 
> 3. Start using the upper 32-bit of HWCAP and HWCAP2 (we initially didn't
>    go into these as there was a slight chance of merging ILP32). Does
>    the libc rely on the upper bits for anything? Or does it just assume
>    a 32-bit HWCAPs layout?

top 2 bits of a 64bit AT_HWCAP should be reserved for libc.
(glibc uses them internally)

otherwise glibc can work with 64bit hwcaps.

> 
> 4. Introduce HWCAP3.
> 
> Szabolcs, any thoughts?

i'd go with AT_HWCAP3 and keep using the bottom 32bit for now.
(this requires some new code in glibc, but not excessive)

thanks.
