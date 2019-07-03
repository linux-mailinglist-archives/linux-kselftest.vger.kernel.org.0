Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99375DFFF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 10:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCIjz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 04:39:55 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:4110
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbfGCIjy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 04:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd+p4P0v1GRtEzkV6iabRuDZ13tH30t1G14nZuNrOrw=;
 b=aUjYyKP8RTcgleOUccDt9sJYxx6Yk8gQXmrPA24fMxZuik9VZcv8z6/xpTYhPcqtSYod+4gsOWsoUWiOQmNX739sWWK7ik5aWS7ZrwBSmpz3hyp4rbUqIqQOAVA0LONDSlX3X7So5SSrBWRqhN5RYGW4a7TRWSglNL4AZ9U/nDI=
Received: from VI1PR08CA0235.eurprd08.prod.outlook.com (2603:10a6:802:15::44)
 by VI1PR08MB4319.eurprd08.prod.outlook.com (2603:10a6:803:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Wed, 3 Jul
 2019 08:39:41 +0000
Received: from VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by VI1PR08CA0235.outlook.office365.com
 (2603:10a6:802:15::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.17 via Frontend
 Transport; Wed, 3 Jul 2019 08:39:40 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT016.mail.protection.outlook.com (10.152.18.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 3 Jul 2019 08:39:39 +0000
Received: ("Tessian outbound 4988ae2fa87d:v23"); Wed, 03 Jul 2019 08:39:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e203cded201446c7
X-CR-MTA-TID: 64aa7808
Received: from 9ddbd570a47e.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 43A4BA1C-E423-417C-8319-C6C164FB4C05.1;
        Wed, 03 Jul 2019 08:39:33 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9ddbd570a47e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 03 Jul 2019 08:39:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPwtVfGL3BmrUzWTwhasGZPsCUTG1h1en9Ut8hRKxpQ=;
 b=KCRZj/0pPFaNkJtnOzrvJoMfjaxI16R2fN8fuquyyIl32pg0VoN9qiH7gRpf5aC5wFGdDuYJoYS2I/YkhNsaeA5Dwb9oFth8jwagwCm96pT6r1zF5iFoqdeWcbFmWw7yqsVmCL/QcmEa5Szzg+lzVf6rOojbfipo0Fwv9vybfak=
Received: from AM6PR08MB4504.eurprd08.prod.outlook.com (20.179.18.87) by
 AM6PR08MB3510.eurprd08.prod.outlook.com (20.177.114.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Wed, 3 Jul 2019 08:39:31 +0000
Received: from AM6PR08MB4504.eurprd08.prod.outlook.com
 ([fe80::2cb5:e8f9:38fd:7f5b]) by AM6PR08MB4504.eurprd08.prod.outlook.com
 ([fe80::2cb5:e8f9:38fd:7f5b%3]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 08:39:31 +0000
From:   Dave P Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <Cristian.Marussi@arm.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "andreyknvl@google.com" <andreyknvl@google.com>
Subject: Re: [PATCH 03/13] kselftest: arm64: mangle_sp_misaligned
Thread-Topic: [PATCH 03/13] kselftest: arm64: mangle_sp_misaligned
Thread-Index: AQHVIdkqvNuM1VCtMUOFwCq2jCSYqaa3lRJhgAEc44A=
Date:   Wed, 3 Jul 2019 08:39:31 +0000
Message-ID: <20190703083928.GX26585@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-4-cristian.marussi@arm.com>
 <20190621103518.GK2790@e103592.cambridge.arm.com>
 <68cc7940-4ee0-b06c-7bd3-b1fbfbc9e142@arm.com>
In-Reply-To: <68cc7940-4ee0-b06c-7bd3-b1fbfbc9e142@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0411.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::15) To AM6PR08MB4504.eurprd08.prod.outlook.com
 (2603:10a6:20b:72::23)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1fa4540e-d3a9-4008-ec02-08d6ff91fca5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB3510;
X-MS-TrafficTypeDiagnostic: AM6PR08MB3510:|VI1PR08MB4319:
X-Microsoft-Antispam-PRVS: <VI1PR08MB4319BA06C8745054BED66091FEFB0@VI1PR08MB4319.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 00872B689F
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(189003)(199004)(229853002)(6512007)(81156014)(33656002)(81166006)(6436002)(52116002)(305945005)(53546011)(71190400001)(386003)(6506007)(6636002)(14444005)(8936002)(7736002)(68736007)(4326008)(6486002)(64756008)(256004)(1076003)(99286004)(6862004)(26005)(25786009)(5660300002)(58126008)(54906003)(102836004)(316002)(76176011)(2906002)(14454004)(86362001)(53936002)(66476007)(66066001)(66556008)(186003)(478600001)(3846002)(6246003)(446003)(8676002)(66946007)(11346002)(66446008)(72206003)(486006)(6116002)(476003)(71200400001)(73956011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3510;H:AM6PR08MB4504.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: lDpW9qyLPHVtOLG6WHRMMMgWJEZJoKOKzjnAzUHytuCBRvQe0tN2uoURvrGn0kPSY7wI4sUXNtZINuX/qY7R/JZJJ+N/lZiAV9ak1lbDITpfz6UbD/k+84VDuQovc/DcbsG3AY/1objsGRmt6xY/cmKUlSH9WfCwcpVzoQtkjG0OGmt5wohxn0H8Xxnbg8b8DZf1Ei4u2F9YgNSr+m6Mi0dRj17meTc/BAPiUeBTJk0ZzrEPg/6bs3DuppeKmJq0QySLV9ozGcfKR0SeCjjhY624r7RfKxUAtO//yMVD70/R5vG3GugsoFsDatPAbcyzlFBYemf2lyYzIAA725hti6rypuMIQqBgMm+sxhisXOEfHt0aJlEKgJroUoe8T63el1pq5d3zEelZnvaxISNyPAzNtfLW8fXe43+TdI6rpnM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6AFAF48C1561E846AC50332AB23C1345@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3510
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: =?us-ascii?Q?CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS?=
 =?us-ascii?Q?:(10009020)(979002)(4636009)(376002)(136003)(39860400002)(34?=
 =?us-ascii?Q?6002)(396003)(2980300002)(40434004)(189003)(199004)(46406003?=
 =?us-ascii?Q?)(26826003)(478600001)(72206003)(81166006)(81156014)(8676002?=
 =?us-ascii?Q?)(486006)(14454004)(4326008)(8746002)(2906002)(86362001)(633?=
 =?us-ascii?Q?70400001)(305945005)(7736002)(126002)(476003)(63350400001)(5?=
 =?us-ascii?Q?024004)(11346002)(14444005)(25786009)(446003)(97756001)(5046?=
 =?us-ascii?Q?6002)(47776003)(6246003)(76176011)(26005)(66066001)(186003)(?=
 =?us-ascii?Q?99286004)(102836004)(336012)(70206006)(316002)(23726003)(611?=
 =?us-ascii?Q?6002)(6862004)(386003)(53546011)(70586007)(76130400001)(8936?=
 =?us-ascii?Q?002)(107886003)(6506007)(3846002)(54906003)(22756006)(566030?=
 =?us-ascii?Q?0002)(6486002)(6512007)(58126008)(356004)(36906005)(6636002)?=
 =?us-ascii?Q?(229853002)(1076003)(33656002)(969003)(989001)(999001)(10090?=
 =?us-ascii?Q?01)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4319;H:64a?=
 =?us-ascii?Q?a7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempErro?=
 =?us-ascii?Q?r;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.c?=
 =?us-ascii?Q?om;MX:1;A:1;?=
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6a901f73-dc33-4720-b7fa-08d6ff91f7ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR08MB4319;
X-Forefront-PRVS: 00872B689F
X-Microsoft-Antispam-Message-Info: KqtXT7/ABZxe8HwZMAgySBxmd/wtUYSU/eSeJC/tjYLJhHHKs1TLcohpRT6xyAl14FJ75JTZjtH5HsjwryLAsz6W1OsEpnwuE/4wB2KjNs3xQlQK31Thu17C9nkXMxBQIhScvMdFVy3GuqYNsbPtqpmdJOMZpsSoS+kK0m4TVCCDEwWmjQfZd1PtX4ubZwWxko/AWKqdCPpOHJ/BiBdBBFeMek9WHTLGC3FnSgBumLJvvsKZA77MUw3CFwvw+j/VVVBd8ouSPEDEsJT3GX9TQvpq91qqDWA3F/SFM2xY3vWjjcc46F6W7QRPV1qxuQq+3ppWlgR3NKAAsMc3uYVvlVdsNuTtXSKibhMohCChSD2I62YK58J3hlRYF/969Wxg1gUIKpz1+7+X1pQsycSYWygtRmy/OdawvzmK01xhBTw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2019 08:39:39.2345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa4540e-d3a9-4008-ec02-08d6ff91fca5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4319
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 02, 2019 at 04:39:44PM +0100, Cristian Marussi wrote:
> Hi
>
> On 6/21/19 11:35 AM, Dave Martin wrote:
> > On Thu, Jun 13, 2019 at 12:13:25PM +0100, Cristian Marussi wrote:
> >> Added a simple mangle testcase which messes with the ucontext_t
> >> from within the sig_handler, trying to badly modify and misalign the S=
P.
> >> Expects SIGBUS on test PASS.
> >>
> >> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >> ---
> >>   .../arm64/signal/testcases/.gitignore         |  1 +
> >>   .../signal/testcases/mangle_sp_misaligned.c   | 24 +++++++++++++++++=
++
> >>   2 files changed, 25 insertions(+)
> >>   create mode 100644 tools/testing/selftests/arm64/signal/testcases/.g=
itignore
> >>   create mode 100644 tools/testing/selftests/arm64/signal/testcases/ma=
ngle_sp_misaligned.c
> >>
> >> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore=
 b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> >> new file mode 100644
> >> index 000000000000..7f7414d241f2
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
> >> @@ -0,0 +1 @@
> >> +mangle_sp_misaligned
> >> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_sp_=
misaligned.c b/tools/testing/selftests/arm64/signal/testcases/mangle_sp_mis=
aligned.c
> >> new file mode 100644
> >> index 000000000000..41bd27312e54
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_sp_misalig=
ned.c
> >> @@ -0,0 +1,24 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/* Copyright (C) 2019 ARM Limited */
> >> +
> >> +#include "test_signals_utils.h"
> >> +#include "testcases.h"
> >> +
> >> +static int mangle_misaligned_sp_run(struct tdescr *td, siginfo_t *si,
> >> +                              ucontext_t *uc)
> >> +{
> >> +  ASSERT_GOOD_CONTEXT(uc);
> >> +
> >> +  uc->uc_mcontext.sp +=3D 3;
> >
> > What are we testing here?
> >
> > It is archietcturally permitted (if unusual) to have a misaligned sp in
> > userspace.
> >
> > So are we just getting a SIGBUS after the sigreturn, when the thread
> > tries to dereference sp?  If so, we aren't really testing anything abou=
t
> > sigreturn here -- I don't see any check in the kernel when restoring sp
> > in sigreturn.
> >
> > Even if there were no SIGBUS, the thread stack is now corrupt (due to
> > wrong sp), so the interrupted code is unlikely to continue running
> > successfully.
> >
> > Am I missing something?
> >
>
> The initial (flawed) attempt was to test the check in arm64 rt_sigreturn
> kernel code:
>
> if (regs->sp & 15)
>       goto badframe;
>
> BUT in fact such initial check happens at the start of rt_sigreturn
> syscall well before the regs are restored from the uc context in the
> sigframe which I mangled
>
> i.e.
> restore_sigframe() -->> __get_user_error(regs->sp...)
>
> =3D=3D>> uc.uc_mcontext.sp --> regs->sp
>
> happens AFTER the above regs->sp alignment check.
>
> So the check is performed on the effective SP value at the time of
> kernel entry of sigreturn NOT on the uc.uc_mcontext.sp MANGLED value, so
> this is not really a sigreturn related test at this point. (and hence
> the SIGBUS instead of the SEGV).
>
> So an option could be as you proposed in another similarly flawed test
> to mangle uc.uc_mcontext.sp to point to something unreasonable and in
> Kernel space (at least virtually)

I think a misaligned sp (i.e., the sp register, not uc_mcontext.sp) at
sigreturn, and an sp that points to unmapped or kernel address space
would be useful tests.

If those are already done elsewhere in the series, that's fine.

(There are many possible variations on this theme, but we have to stop
somewhere.)

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
