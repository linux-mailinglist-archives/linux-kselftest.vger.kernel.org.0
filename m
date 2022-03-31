Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2361E4EDE5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 18:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiCaQIT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Mar 2022 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbiCaQIO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Mar 2022 12:08:14 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50063.outbound.protection.outlook.com [40.107.5.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA7558384
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Mar 2022 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e47JLb4kfultrgpDC/XyWPyxOnLl59POSPiq4zw707Y=;
 b=lLQBeJysn4OAt69NQDqfgxPPBkUhFUX0ncp1NyCXcPN2DYR53CaZzAV7AMBgWePOB0ig38UBJ/+kopHCj2NbPC1mSWLI5phqiMqpEv/lZVmOi8FomHbpTRP03Rk/nFm7DnmW+hv6L8zmedp5i2d6x3C2UPtDC91dQ+iYeQ2yErw=
Received: from DU2PR04CA0228.eurprd04.prod.outlook.com (2603:10a6:10:2b1::23)
 by PAXPR08MB7365.eurprd08.prod.outlook.com (2603:10a6:102:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.20; Thu, 31 Mar
 2022 16:06:16 +0000
Received: from DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b1:cafe::3) by DU2PR04CA0228.outlook.office365.com
 (2603:10a6:10:2b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.22 via Frontend
 Transport; Thu, 31 Mar 2022 16:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT045.mail.protection.outlook.com (10.152.21.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 16:06:16 +0000
Received: ("Tessian outbound facaf1373bbd:v118"); Thu, 31 Mar 2022 16:06:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a3bb062844f73ebf
X-CR-MTA-TID: 64aa7808
Received: from 6e11f4d42098.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7C4BE570-191F-43B1-B37F-463E7A164836.1;
        Thu, 31 Mar 2022 16:06:10 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6e11f4d42098.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 31 Mar 2022 16:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI8uzOSepFiVh8MFjCT0KmAedleOgwI7tdoCnf6ko0rWU0VVuWY8/pStuJSQVgc71R+gWgm2RlKjfIuS3ZOQTRK6Z9dvmShYge87dNlUMXTwxibPuSzrDwg4QM932ZgPFAKC7xhfLBhMv+w02FE9teaPCElQENCtxsGbbEKFKkJ0UKIwJV8ildl9JXxDH1RQXOnBRPr8WsxJnIPqlEl26dkuXCcYDW+sKlyApz+l7U2flU4fIehveSp+Z6AV50ynX/kk4F//CrGv5gzX2W5xjBsn0+3Vp0+q3qSLnQQ9lBd17bdooRKw6ahYUEhI1+c8i9ZYQ/oTb9WXrf6Rhh7+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e47JLb4kfultrgpDC/XyWPyxOnLl59POSPiq4zw707Y=;
 b=K7VaasQY5TkBsGt0qO+xr9x49Tn2UkFiDYEhFyZQ6uUrnCz6iUdZXgFlYSdg67ESKxRdH+IbFheP7LsMYybtV+sOoP3iNXG6v5en04q4RxctbjssR6afzJblPL/GhFu/cmkUZcl3jox4J1TekD+6/rOr0kxIzxsFhD2zcWYa8683JDe03sz8k4rcZWwE4P1z8zBFaTT/KdDgqq3jyZu3Ce9mVYGiT4MU1BIBWJwhwDi5HH2Z0plM5MDbjirnVczmhpvvb85M0O9PmFywmLHRNHS+JKZUe6FGJ4JwD96P+hgTFbt6KWBGR+vHjkEbQTOfZHNt7no9Nns6cLOaXadbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e47JLb4kfultrgpDC/XyWPyxOnLl59POSPiq4zw707Y=;
 b=lLQBeJysn4OAt69NQDqfgxPPBkUhFUX0ncp1NyCXcPN2DYR53CaZzAV7AMBgWePOB0ig38UBJ/+kopHCj2NbPC1mSWLI5phqiMqpEv/lZVmOi8FomHbpTRP03Rk/nFm7DnmW+hv6L8zmedp5i2d6x3C2UPtDC91dQ+iYeQ2yErw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB7PR08MB3801.eurprd08.prod.outlook.com (2603:10a6:10:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 16:06:01 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d6e:f858:129f:f240]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7d6e:f858:129f:f240%3]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 16:06:01 +0000
Date:   Thu, 31 Mar 2022 16:05:38 +0000
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
Message-ID: <YkXRUlaoyDKQqndc@arm.com>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-7-broonie@kernel.org>
 <20220311172051.GA257833@arm.com>
 <YiuYMcR8zk73eBLo@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YiuYMcR8zk73eBLo@sirena.org.uk>
X-ClientProxiedBy: DM6PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:5:bc::31) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6091be44-3432-428e-ce60-08da133062bf
X-MS-TrafficTypeDiagnostic: DB7PR08MB3801:EE_|DB5EUR03FT045:EE_|PAXPR08MB7365:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB7365123A88E48A69D898035FEDE19@PAXPR08MB7365.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EIj44gwabxbR5ITA5r8Mrk51k8iMmJfAaaJIrLyDOVDfBMP/srEctfN+xQ9H80PhsIt8wBaDAj6fHykt1ElriIhilI4wWr+8feqNmgaBGLq/kkHqv+3Fyn5babPd8XMb+9ygl+EYN0b30y9+zf9HoAO6XUcgTy82GBCdIpzkfeVrfQn2UZMDi9VYWujV+UTSOd9zRP0N5SQ1YlXr1UwTjCJET6JUcgyPQVYLbfMQZypIxeIKhYx0xcN7MCPwmKYz/9RopIg8b4KjGoxVk53sW0y80YZvhFaBzJr6wjMY7jI7NGqnyz82NtR32Pxd4Deg7y1Iaiv3JYZ+mlHgYl0ayvxrrr8TIGZ4sJpzV1gu6Sg1airzYvJPSOLYv/CDCHKoT8r2MCgklBiw2wLoKaY9Nwt0BAOtKPPUhdNTxU98NmXH6qKhTNUuB5rU1qayWl2l8EPzzevG7NIU9MlkJ6A4KOQ9j0bJvIZe4Q2y/iKmBzAqE3JwDW98/EMONGQ14AgclWfycOxJVOSNA/5Q1+UUk/Sa82eAM/vbkIoch0Ch0qWA6l7tnEHxXPzfqafFibsYXQ7om8Huv1iv9k6wkgexBrw+OMOkatc0i4Pc+vDDy3MW/thxr+8BzWt8lFO0PdCHVJgpbjvG6ylWa6sa4I9jxw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(66476007)(186003)(6506007)(2616005)(6512007)(66556008)(8676002)(4326008)(26005)(38100700002)(6666004)(66946007)(6916009)(54906003)(5660300002)(316002)(36756003)(8936002)(6486002)(86362001)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3801
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4ecadc2b-5442-4976-05c9-08da13305967
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sX+nA+dMrCpJbLQr2Sc4TrDA3oi5UplNXWZ9U4focHGE35jnHhuzYiKdOop+PWNfQxdw50yIu6MlmHKYFjOCM64TKzyF5i0HJmwCbsWhVaqHHNchQgxFxrVzDv5MOZiWDaGggmtQfPMQyJXoR/S6FRqIjAFiOL9A0vwzPLA93vrCRD2Fr9Ij97xA9swZ9994EClYnZDO5Pu21WB8UASsLssJE+6bba7nNd9SNqbCghILXzMRwXjpUHkD8MTqMQwNwlsBh2yM0XGGCjw90XTJ0XXdlaTuXJI3vw2WSJwa3OtXovlgc5CelOm9T6P/EOd4F718c0H8qi4NrDmo6Pkpvm/7PpH4OM1n7CGjqNC4dfJ1lfNcna07RFMR5yhSmaxuRkmFsoeyrDEzA4rkdBL7cjQKHytPE6Olpf8Ufbiy2FrCCUBjJGSBcW1zoYu0ivjsv6SmuhmptonNtNDy4vD06+6KVEou8vIacBPRw1dbgz4/zriXeMAjZxIVv3wkrerUGvw3IpxpVueaKzbTGZxZE2UUwFb77yvhX9Kd8YZWxConR1n2/CuKAVcWgRMw+7HLYndIa5G1Wy6XiYhIJ2vhShrhXVBjPQmevP6DSWn3MSKM7OCTeSzcidv21VawEcsu/lmVVvUyvr4WJDsv2bdxzo0CCQgZ16eHaRlSZ4ubqiFbym/tapbGsIGkfNTU6k//
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(86362001)(81166007)(6862004)(356005)(336012)(40460700003)(508600001)(6506007)(4326008)(8676002)(82310400004)(26005)(36860700001)(6512007)(70586007)(70206006)(54906003)(36756003)(8936002)(186003)(316002)(6666004)(6486002)(107886003)(2616005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:06:16.2285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6091be44-3432-428e-ce60-08da133062bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7365
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 03/11/2022 18:42, Mark Brown wrote:
> On Fri, Mar 11, 2022 at 05:21:21PM +0000, Szabolcs Nagy wrote:
> > The 02/25/2022 16:58, Mark Brown wrote:
> > > +* On creation fork() or clone() the newly created process will have PSTATE.SM
> > > +  and PSTATE.ZA cleared.
> 
> > is there a reason why fork() clears ZA?
> 
> > i think this is a minor issue, but the usual expectation is that
> > on thread creation thread local state is reset in the child, but
> > in a forked child the state is the same as in the parent (where
> > ZA is preserved according to the first rule).
> 
> It was partly consistency with SM and the SVE state (though that is also
> covered by just being in a system call unlike ZA) and partly concerns
> about what happens if the fork() happens in library code which isn't SME
> aware - it would end up carrying around a copy of ZA with associated
> power and performance impacts if it doesn't exec().  Overall it seemed
> like there would to be less potential for unpleasant surprises if we
> consistently discard the data.
> 
> That's not a *super* strongly held opinion though, we could switch to
> preserving whenever we preserve TPIDR2.

i think it's slightly better to treat ZA like TPIDR2,
so only clear if CLONE_SETTLS is set.

otherwise in principle the child can return to the frame
where ZA was used and expect it to work (it's hard to
come up with a reason why would some code do that, but
this is valid in a single-threaded fork child).

sorry for not deciding this earlier.
