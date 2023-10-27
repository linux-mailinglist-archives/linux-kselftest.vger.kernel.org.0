Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D77D96ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJ0Lul (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345686AbjJ0Luk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 07:50:40 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008BDC0;
        Fri, 27 Oct 2023 04:50:36 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=h8QPtOTHR92Ic4FjvAGa7ls9AkZ34+JDmiohBh/NX+uciMYQXfrkSKcxK2M26BpNn5XjWuyeKKJpunwCu6lZsGVZvR8qNbyRvHSJjbJ5iCd2LgXTIHtg3Ddu4/K1V6nx8IGYsdSlFARhZF9RiqHCK0aeoSbnio5IbdxF31W38gm/k2T+buTmN0AQj6Sawi8Wn259t/c41UtQvGUj6LlZuJci/obFPKZUR0VqCxdlP2RhkyWjM06h8z4j+U0rK7Yk7I9gtOVV97L87WLZW7D17lSYb5a8j42XYom2lv3baYlbLCxoE9G6usxC9v67270usjyydGRmMYVlP31hv3ctmA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3CNqvpl5wOwpmNdubs1M+byBphTv0pF2kWdLIvzTiM=;
 b=RA8m48ABQbiqzYkgLofZbllzANKE1ho42Tvgod/ZRIg6avBIqak1sTspNjeGfarBwtAC5/QeTjH06dVz5UqvuGM6seXiFhNWQVBZo64WbW5BbFjijxAxc3veZyFHbbJ7yn8pIAVe5jqEYi3BOTBpGxiMx/FVx6SG8It01hsIY929iKYToVBMRI84/b+1N+MTyI4lC936xiWRgM49t089xFSOeECQ9Nsv9NQCYV2EURKjimELkM2cFK+hy+t0B+UVSGUWJRKywzokQwD4lK6TOEtzbaT3HTSyUkgvbJD6TT9WuEhRVRr4KSLer3mUy3fpWhmLTKf7z4Hb3eirxk9Ogw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3CNqvpl5wOwpmNdubs1M+byBphTv0pF2kWdLIvzTiM=;
 b=B8VOPXKaZX+Q83d3PqCzSTaa0dF/ytOq9NvAmS+aB4Vbm1ocVIEiiJxLjKcQlu972WcFyu7TN/mxzcRp70avJ2b9T0VMaBFeIfq/O6HZQcAQXTnZ8SvYzNqC3iXGKmRpqIJitmmCNq5E6aeZm/yj8/gDEmjCgQk3sx+1Gq3LSaU=
Received: from AS9PR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::28) by PA6PR08MB10419.eurprd08.prod.outlook.com
 (2603:10a6:102:3c8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 11:50:30 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:542:cafe::13) by AS9PR01CA0047.outlook.office365.com
 (2603:10a6:20b:542::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24 via Frontend
 Transport; Fri, 27 Oct 2023 11:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 11:50:28 +0000
Received: ("Tessian outbound 8289ea11ec17:v228"); Fri, 27 Oct 2023 11:50:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f8c8724e58386712
X-CR-MTA-TID: 64aa7808
Received: from c650e82de1cf.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 758994F8-E151-49AF-B6E0-8E4091EC9BC5.1;
        Fri, 27 Oct 2023 11:50:17 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c650e82de1cf.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Oct 2023 11:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agB3YwiM3WZW93M5u37ZbwME18Dr+3NSIcV0+hzOyiF4mdN4taV1sc8ZBT48wLvf8816DhFG9wzr3diNDnjo3PfmxoR+w2iI6L6vZBJAqyVoKTVPToj6kkRtqFmCALppr2oVyknjqqLjeRwy6Nc88kifKSjEWHOF8JUL61H+y9SkY0bYpU4A1KGLCwnA2oAm9fdEsqAFIdNdKBjGCgWZhxhUfiyifFiaHExv+dmgMWxYMOxnxvQ+Udo2e5DPVzik2NKGpwBLYk+bXqUfdpS+HhinveOarLKU5B13/8K8K0twzfIsX3wXwetY6t8hyTIfniIulSqrCQUgygcFSTZuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3CNqvpl5wOwpmNdubs1M+byBphTv0pF2kWdLIvzTiM=;
 b=UOnRmgCOUw8IJ7Ax+HeAPqwJjwdiP1takhPKNEhP9AVIaw0a6LkiREy0OxurzZOxtLh1b2pQalRlDNmAErSNI3EfOogrjbFg+QXqVwIhrqV0MBLEEBPos9sKK63CDjz3CiFciRZT5zOHqYuMygh3Hwy6I/YPsdOjmKsGd3nULoAGQWBB/ZiKqnJdi3ZFQO+idme2GrZL6ToZj5/HWCcvA86x0x3I4fd6gF5TfynkDXGj+UarXle9Z4W7SJCYaAcSq5rKwHSP+xDkgTao6oGm/Iy3jQrx55RQcz4kdkxqZrF2EEoRcvNR5e+KZasw4oG7jsXejKBlZ2NQQ0eZjhltKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3CNqvpl5wOwpmNdubs1M+byBphTv0pF2kWdLIvzTiM=;
 b=B8VOPXKaZX+Q83d3PqCzSTaa0dF/ytOq9NvAmS+aB4Vbm1ocVIEiiJxLjKcQlu972WcFyu7TN/mxzcRp70avJ2b9T0VMaBFeIfq/O6HZQcAQXTnZ8SvYzNqC3iXGKmRpqIJitmmCNq5E6aeZm/yj8/gDEmjCgQk3sx+1Gq3LSaU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by PAXPR08MB6592.eurprd08.prod.outlook.com (2603:10a6:102:158::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 11:50:14 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7279:cb15:78e8:3831]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::7279:cb15:78e8:3831%5]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 11:50:14 +0000
Date:   Fri, 27 Oct 2023 12:49:59 +0100
From:   "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
To:     Deepak Gupta <debug@rivosinc.com>, Mark Brown <broonie@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZTuj565SqIb9KjQr@arm.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
 <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
 <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
 <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
 <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
 <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
 <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
X-ClientProxiedBy: LO2P265CA0288.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::36) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|PAXPR08MB6592:EE_|AM2PEPF0001C70D:EE_|PA6PR08MB10419:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bee80fb-8289-47b3-4f4d-08dbd6e2ea55
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8Hd6YIRoNn8F6LBeqdZinFpdgKOG1xHSbHDB/2L1mnn1NJzfLyHugwVTR1wg83EgghQjw0fTDCWW6ceLZnPmBvx65loP2QYUr/wOK2oVyetAlftfOE4EkfkMimkDTEOIj/k4Xv+oCtyPUw2gX7rnicUbYlc6FZElaHa9VtxlA3Bm+wl8MFmPK+I/VZ8I219ffaLj8duu0NQZAODPrwDsJIRArgxZRwp3js4nvxvBuKmC8I7I6aYOTnnkTZZJlFLKdpPCjYH6mcgUMjc1uijKm0PBDFCiUenI9mfmZ8u8bV4o/D96/2S9o5Ky+O7ZoxDGU1kWPR3P4sAa3C7NhvTAW+Mo7FlICgq2ZxtKEJMgRRRgITifYynQOuHhEyEnS1/sXHsUuFwkdz8IyWLwiLIPqPJkhoyyg19a27MA5TUdD6Lvw5W2jLLMsyjpWpW2qPhUgmoBG/YVoo44VD4w/H46245duh+xKnSfwjaAFhU/RVG4F7xDDfgS57sldXdZWUWHL4mJpSI7PJUhXo/hFsd4nOFfLlf9EjzX43+pC3X3zyeeZfDPFpeCB+uOQTrQRTZC
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(36756003)(6666004)(6506007)(6512007)(38100700002)(2616005)(26005)(4326008)(66476007)(110136005)(54906003)(66556008)(41300700001)(7416002)(66946007)(2906002)(5660300002)(86362001)(8676002)(8936002)(6486002)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6592
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4b6f275e-38cf-41f3-76ce-08dbd6e2e1ad
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEuAXESOGDtdx2bbUjc9IzClH1GsXLlIqDEQ2YflhkOjWiMmWGlw2e1OzUnkrnL5VQV0KRczzcfybAYO5Ed7wA+Np576Eggftqma5s/sjoiHB/7lCv60F9xw5PyulnSeLpG/qgXxIbj+FXMzcdzrg/70mfHzDN10acN/9yJcjicvaiPQXebrZHhvDy4fM685yGfeW0jLU4ZGrAyH0Fgw2Iq3xKP12jf7h5O4OgfXfqRUwiOefo7DYHbFkVqUv4qlayHfp+8NFEWNogryqBYZKTIyZ1hLmR64gvGQgs2FR1pnwqiW/xOBkUUW98FdIZ7MySof4PEZ76eddapXVUwZ7Z+9UNmy6i1ZiruvyxRDfqg9I8tFnp4QZdHOssl8VapHQPi7B/LtCfaoS6AL9OQvXHOEiwb6BRyUJaFKAtWAw6LlxtQMP9ajB+0hqbS9DIEcRw2/fHi6dZVsDNJ1SyesW4U9ck8IAONRlUJ6g83leAS4omnqPwP9v8aXKrz8fTjRBy+HcGTRLQMTXZKeeYcgEOM8LqVdFHte39+Ldma7uDrXozfmFxfcR9FICOkOt+4qq0YyzVnM90KpMoCsWLAPoW5cToT/DZTSNEQecvBVeFEYAhyOgMiH4IJ/kDKjYLYgs/kxyx3/12ezZXDDXdD/pV0WC/W9WqMg3tEpJlLE163P8+IAArZJFyi6cZPtBh4DRnG/g7vrAaOtQmmEOY1o63Kk9HwuKHsdkEvOKm3O0HS1LCG/Z9cVnAD5NuXsmVKx
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(2616005)(6512007)(41300700001)(336012)(81166007)(5660300002)(356005)(40480700001)(107886003)(6486002)(26005)(8676002)(450100002)(8936002)(4326008)(478600001)(70206006)(110136005)(70586007)(54906003)(316002)(36756003)(6506007)(6666004)(40460700003)(86362001)(2906002)(36860700001)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:50:28.4375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bee80fb-8289-47b3-4f4d-08dbd6e2ea55
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 10/26/2023 13:40, Deepak Gupta wrote:
> On Thu, Oct 26, 2023 at 06:53:37PM +0100, Mark Brown wrote:
> > I'm not sure placement control is essential but the other bit of it is
> > the freeing of the shadow stack, especially if userspace is doing stack
> > switches the current behaviour where we free the stack when the thread
> > is exiting doesn't feel great exactly.  It's mainly an issue for
> > programs that pivot stacks which isn't the common case but it is a
> > general sharp edge.
>
> In general, I am assuming such placement requirements emanate because
> regular stack holds data (local args, etc) as well and thus software may
> make assumptions about how stack frame is prepared and may worry about
> layout and such. In case of shadow stack, it can only hold return

no. the lifetime is the issue: a stack in principle can outlive
a thread and resumed even after the original thread exited.
for that to work the shadow stack has to outlive the thread too.

(or the other way around: a stack can be freed before the thread
exits, if the thread pivots away from that stack.)

posix threads etc. don't allow this, but the linux syscall abi
(clone) does allow it.

i think it is reasonable to tie the shadow stack lifetime to the
thread lifetime, but this clearly introduces a limitation on how
the clone api can be used. such constraint on the userspace
programming model is normally a bad decision, but given that most
software (including all posix conforming code) is not affected,
i think it is acceptable for an opt-in feature like shadow stack.

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
