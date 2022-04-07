Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688E04F8332
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Apr 2022 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiDGP3m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 11:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbiDGP3l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 11:29:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F901DAFBB
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DYJPbqbMTefh4/EV7Psv9Uvm0xo4FxgF5ec81JkoQY=;
 b=NrAPQpGIrEsGN1nNJQ0Bfsdkn8zlMygJES1d7/GxzQ/i3YvU5P+NYn5+NqFRH8l8UVF9/g2amJY/jBDic9p+UwgeRyUmOSg15uKfp+Kk8As4QZHKohteO0PJz20XcmzF9Q68zP/B2D37mxU9Q8r/Cc6hdcZjA0owK4NUpYY5Hv4=
Received: from AS9PR06CA0226.eurprd06.prod.outlook.com (2603:10a6:20b:45e::25)
 by AM8PR08MB6545.eurprd08.prod.outlook.com (2603:10a6:20b:368::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 15:27:25 +0000
Received: from VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45e:cafe::c) by AS9PR06CA0226.outlook.office365.com
 (2603:10a6:20b:45e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Thu, 7 Apr 2022 15:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT041.mail.protection.outlook.com (10.152.19.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.21 via Frontend Transport; Thu, 7 Apr 2022 15:27:25 +0000
Received: ("Tessian outbound ab7864ef57f2:v118"); Thu, 07 Apr 2022 15:27:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e349379e7b40d365
X-CR-MTA-TID: 64aa7808
Received: from 06199e09e2a3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CBB03ABE-EB92-458A-9E42-34B7390FA3C7.1;
        Thu, 07 Apr 2022 15:27:14 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 06199e09e2a3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 07 Apr 2022 15:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IojUGaNG2EMdkTfOSKQLPfo5JYUWdHoxm+e1jJMn3mAbV4/oKYH7rWMb0YQt+O1TvgiZluMSu/OzxfUudTsjo5kHNDnh2xZw6tiHjxugf7pF9kNNcIRUcNumN5CgCIIWumRtkeVcTYkkX3aCN4JUbkmO4DWnD6/qa0JXaHqbye9vliJPn9utrX9qmzoWqmw94Ixdzi/cgfD5xl3XOLn7uhoqgfVGurFeTgiZVKe3jq3UFc5FBW183HgAEoFguMa7d/YWNnHA05dFiKHFo7HYhCArkBQ6s4WLyTMgcohAshlTDNb1TFi7dyCy7zt/NiXOyHxrht90EmehkXAtRT1t7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DYJPbqbMTefh4/EV7Psv9Uvm0xo4FxgF5ec81JkoQY=;
 b=SXOAiw++aybq//J+MDz0OmAPTDOZftAnvt03tMd6gAoCnlTSgx7YTSOxwZppSvcjWZfMjJpR6NiQkZEIsxX6Ki1TCq1tjYOvbr6KiEYlx8bF4qQEhiW9wZSZ/fDnSUmAmIzjf2sKDZBaqA5RgOzDb/WhDYYCO6nZdyqPz36fvqn0e+5IX6piXeuCl1UoDh0sT0+laI/QA4HtJ/xsDtELW0SUpFI7gmI2r39uu8kTv5Ng3bIlmdwPuWsDp4BIaQuzSAkd+HXzvW3EU6RsFn97sdgv/w7uXoh4X27QWsPDiK0LQtyezKTIuUUhPmySwb/E6agZ5cPb7mje5kyRv8jB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DYJPbqbMTefh4/EV7Psv9Uvm0xo4FxgF5ec81JkoQY=;
 b=NrAPQpGIrEsGN1nNJQ0Bfsdkn8zlMygJES1d7/GxzQ/i3YvU5P+NYn5+NqFRH8l8UVF9/g2amJY/jBDic9p+UwgeRyUmOSg15uKfp+Kk8As4QZHKohteO0PJz20XcmzF9Q68zP/B2D37mxU9Q8r/Cc6hdcZjA0owK4NUpYY5Hv4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM6PR08MB4769.eurprd08.prod.outlook.com (2603:10a6:20b:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Thu, 7 Apr
 2022 15:27:08 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::cb9:d4f8:1295:a076]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::cb9:d4f8:1295:a076%2]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 15:27:08 +0000
Date:   Thu, 7 Apr 2022 15:26:54 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Luis Machado <Luis.Machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant KumarDwivedi <Basant.KumarDwivedi@arm.com>,
        James Morse <James.Morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Subject: Re: [PATCH v12 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <Yk8CvtqrRR4cV6/v@arm.com>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-7-broonie@kernel.org>
 <20220311172051.GA257833@arm.com>
 <YiuYMcR8zk73eBLo@sirena.org.uk>
 <YkXRUlaoyDKQqndc@arm.com>
 <Yk3hDLe8Cce8zkvI@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yk3hDLe8Cce8zkvI@sirena.org.uk>
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c50c89e8-2366-4a20-3404-08da18ab1e7d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4769:EE_|VE1EUR03FT041:EE_|AM8PR08MB6545:EE_
X-Microsoft-Antispam-PRVS: <AM8PR08MB65458888BC82858D91FCCF5CEDE69@AM8PR08MB6545.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: kbHEv98nDAK/8Co1uwg63suWEZGNOK/ekrLOreHWVyvzx9sxO1cBNH9k9xI9d6505sHn1Q1GZj8hpgG3QSCpakZu3/Vt6/0t/p3MZUHrMvQ4w0YISMAgBmiXA6lAVMk7fiEUiECuOxmTlH3ZWFQWJgwsbSjxg/FkFZzfevKhbrZdQhmpnNJ1bFdoOWwP+iCuFGPmfVzEPRK+ZGg87mLsVdoqAVdJMhpHGULIS4vhbmkrzTkIYaN0qPjipA63BCjrx8Ibf0H69nYRzqWNPmCiMyMbY5IoFJGjmm6UzU+9gR8HIKHf0YgWi5dpNc+9YfQ2ND5UD2wvqgqUbys2XFNYcckPBAm0Aq7Kg4AyakzU4+8YVtQWsy6QbRy2I3RcAVO1iRzfvdqMjmPjEN+yhmFU91SJmCJrtwbAYG+owEOFqETWAQWd/0Jg1Dm2fMMo2h+Hgc90MTBryT4oYP7RC78lWzuRVb5/slTtsSAf9nzwosjeaTRnVSDRP+SOUVwj0PHKO7YTu6Sypho8cNBsh6h4cw2fVkrGMwX4U5OavMPWNu3r1uwPsMxWAcmcaUQ0iHYydT/4XD74bLFvCO62RoQ4inmr9iXBC+dpmR004mIwYidQuj9k7W379vhw1v0uX9dKdO/NjLdrWcn9uoUa68G6qw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(8676002)(66946007)(2906002)(86362001)(4326008)(4744005)(66556008)(66476007)(8936002)(6666004)(6512007)(2616005)(26005)(6916009)(6486002)(54906003)(508600001)(316002)(6506007)(36756003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4769
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1c3180ae-f5d3-4d76-137a-08da18ab13c9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHdafW9B6afgpO7FZvb/qgWro3M4r++orOs0nbUUhppwES5ifC8MKctiiTOrDrWpF010oES7v4VIpCZ4Q1R+h6I1mMpJZz9kMupL+Y0ZVHcuJ6GcJxIWN+xhGABSGwMbJbiGr0Dk+QI3Wzz29vLW6lp/ldGW0M5+RpINdwb3Omxfl8WNFDbsI1zzSJsBGRTY7jK9rhlJGpJDWhOkufhhtkhFL9WuyzW8fvHzg0sTOohpGUC2HzDsEOLKEgOgBpdRUvjxQmJRWkyGJKZ864j3fgZ39TSSmzlUmOU83+20vMCpu7LsaNlZDfnOVndhnH/FmVh07B/UBiRqFy/rs1vtvgHHLK0e1gzqT59I5J6wiBlI5sMBIQFYw1qtYcVR5DNE9Lh/ALFrIv07aytP6zyx6eix+QkKdEnNmYpet1xwMxRk85lQ0Sa8OlGzhF973UySK6pLiR3L/QnzB/rDX5dXWGIimgQAT0HHpoDsgJ/bGRGEk7MVZcdQrvpA8QxsV7nm1+obA325Gi6rrVNja+PBD+hIVPcqqbjR6GfJgI0Ll92dKt5Fu8/Uyr53tmZHiI5c7VgH+etEDcFfj/V+d46o3qTO+hIDQLPJcYtK5+F4B290aH1XpV6J5zhuoF4tSXOj0kEUk68GOfbn8V0IxWAPErloh6x/2RxLRoc2ceqn56TrwKssqVEx38a46jmH7joq
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(40460700003)(82310400005)(107886003)(6666004)(316002)(8936002)(81166007)(26005)(47076005)(6506007)(186003)(6486002)(2906002)(70206006)(6862004)(5660300002)(508600001)(2616005)(336012)(8676002)(36756003)(356005)(54906003)(70586007)(86362001)(6512007)(4744005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 15:27:25.5248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50c89e8-2366-4a20-3404-08da18ab1e7d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6545
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 04/06/2022 19:50, Mark Brown wrote:
> On Thu, Mar 31, 2022 at 04:05:38PM +0000, Szabolcs Nagy wrote:
> 
> > i think it's slightly better to treat ZA like TPIDR2,
> > so only clear if CLONE_SETTLS is set.
> 
> > otherwise in principle the child can return to the frame
> > where ZA was used and expect it to work (it's hard to
> > come up with a reason why would some code do that, but
> > this is valid in a single-threaded fork child).
> 
> From an implementation point of view it's a bit clearer if we just
> always preserve PSTATE.ZA and ZA contents on clone() and clear them on
> exec.  Do you see a problem with that?

i think that's ok too.

