Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14587592EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 12:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGSK1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 06:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGSK1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 06:27:10 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A180C2D5B;
        Wed, 19 Jul 2023 03:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBcq4wLJxRy3rOBJo+Q1lBuwSN1LRWjOMSmvfrGUarXZq/AxKoIN4fMp0rtqXkgSb4mQsWLUH+BzNfA/cQJq8DmlfOh1a8pilly44urTzNse/nEtgC75gFbXaboHpzUF3MFnfWfVUi49+xPvFDdXlqVWdju+J3MM0rA5D9qNGMu2E9grHA2Tdfj9oUIs9bM3CWc0/WfMD2jh8x1qmjwGGHpPJIMBlD4wFUr3ebtVy6TNZEXNpNwzdzz9qjk4Llt9Et4Ow8zVSr0BphlSt3PEUBytIy7+COxyPXOV8iWEFFeHnGDZwoBaexYozBvYyxbrHlevKqYgCQ0zbt8VQ6L6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yPrChISRNW+Qm8QNzq6bn+bgezqafyaUhIcATtgFdE=;
 b=c2dRX8SVUxOsLjVDjfarzcidNpwbh7FIfikYgSMf+cibjjOZJsoiHA0XaIdezv97QaK3NxZDkoKGUKEysXMK3w0Kz1lk9T+jGsA9ZXFOF5NXHgqrX3XzDtmtrQhxXdP8OznhLwZ2VTFi83nlVVojHrm8E83gzRyV0F2m7Bl5vMGc0IxkIkNhCTPTo2sK2S8BmIYQuH/snGi2vkLEDmw9Mys4arUnhMPB9tX4s4WByXdB8n15RPT3b7FmWj/a8ft1DH+KeDJtZWYmzzNZ8V0uaGNNt6SPuJKsyYTPJmI7+yQFa/s9s72nnaSjjR498cUxAptWBYh/wiNVvdN9zU24Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yPrChISRNW+Qm8QNzq6bn+bgezqafyaUhIcATtgFdE=;
 b=JvdJc6cEEj7KQ+Xh9XV3iTsMzl3hfucHR8mohlMuTKjs1uaMNj+ak5UJb1+YAoWWNMnUOg/UZ10FjRUQnTa6M7TdDhdA6i8BFnYwO3/n3fTq54w3EWKTczWyLVz0VOrrE1wu5nMjQTH4lT8iAZlNPK8QN/UJw2r63oTczYttpLM=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SN6PR05MB6637.namprd05.prod.outlook.com (2603:10b6:805:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 10:25:28 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 10:25:28 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>, Nadav Amit <namit@vmware.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Thread-Topic: [PATCH v4 00/10] tracing: introducing eventfs
Thread-Index: AQHZtX3ozc4V8XrumUqju4s3WlXUgK+54mYAgALJloCAAuPAgIABWruA
Date:   Wed, 19 Jul 2023 10:25:28 +0000
Message-ID: <2CD72098-08E2-4CAA-B74D-D8C44D318117@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
 <20230714185824.62556254@gandalf.local.home>
 <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
 <20230718094005.32516161@gandalf.local.home>
In-Reply-To: <20230718094005.32516161@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|SN6PR05MB6637:EE_
x-ms-office365-filtering-correlation-id: 2810e40c-b065-47d6-c7fd-08db88427925
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TEFzleaPrKsVAMBo4UG78NWrMgZ94mLQn0+NumLSU99UW0c5ejGnz2w4efmD4lTt6TgyA92NdVWFG1+/fGV+7M0+4PwrNVIj/hO6utITZ2eIM3I1dm3CmzG1o9VQuyT7yzVGaGXoJaU29FATOf548D0KzAHET9x2FmE6P0vrO2gBkOTSz4bHyoiAucMu/4xTHYsFZuZ/oJAaK1/PWW/YpZU7PVDGcPIygO0TMEPLBk0VHF/ZM2h3gKnpxaRfufks4OnoaHNiyH+CI5eVtYp2p/gsE3ORcUq9bCbPt7V6EuPCMhD3FlZx2RSOhsb6HZgmvZfhkXIEujZxBoxnLMUDlteWJ38jfFOhJewqiBe40n+Aw6j1xehZpRRROvhfCTwFOevDN5D/LOS08NDl4tFan509TXwULP1KbDx5rdCHx8H7vnM609jjFti9AVlk19TtP2QQqUAEfacT0Tf6Qws4zWLMT2ZAcutDjSlNkxCjUSoAaL1Lddw6YxZcShxTKSLEOlL7quaLDaoPuGuruGvrl3Qc265OC7aYsbAqsOkvTFu/aoiNPueIKMvpEtozC5hkvETT3krEkyw6ePKmCWYAhHev6n3zuPPwnrpavZSEvp2pr6ttQfhN48O+8zvCZ85HlcE7jnERBRH5EJQtKtXfbdLWUwJb2nkO/MssJkrI4QMQ6s7JIg2VCGYEPrQE5af5dS1Xr82DQ++rjQIX7P7N5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(6512007)(41300700001)(7416002)(8676002)(66446008)(66476007)(66946007)(8936002)(66556008)(6916009)(2906002)(6486002)(54906003)(91956017)(76116006)(122000001)(86362001)(4326008)(316002)(64756008)(36756003)(5660300002)(2616005)(38100700002)(83380400001)(186003)(26005)(6506007)(71200400001)(53546011)(107886003)(33656002)(45080400002)(38070700005)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kHrp7R6S4xpfFUaTxe0TTNcSkim1MS5crYPsIRLGxmNr29aIDk9Qf5PUu0gy?=
 =?us-ascii?Q?Yx9scxQ5w+viGVTd3wI1Zia8WS3dO5SJ4vfe0LnJJkhjAmBuhNHtb5bZYwM/?=
 =?us-ascii?Q?4xtU8GyVueE4upRIwJHVLpvCicZZ/YtT/7dS8lIslxIQsPGCr0ifzDjQmxPQ?=
 =?us-ascii?Q?Ll0TXyNcXDpxbEAUCsjc1o634v36mrzi6kvRictBsEpd4Euw2k5A5UReGv23?=
 =?us-ascii?Q?we1n+mhafMDbHCW4BURKymQmnBZ1sHjVm8dkGVdOjyoso3veMDu28OiGmCjd?=
 =?us-ascii?Q?PQZU+MUJlIkJ6DZgIP9KheFCGHhyb2Ofz7yj1Z9Gmh2pepAMGAnP6rzUf2Q4?=
 =?us-ascii?Q?Qgt2ilFR1QZE1TcNtmdpuz84OSH71g7deW4QcDzRB7xSDKY0dpDJDhRZfWfh?=
 =?us-ascii?Q?CEVrw8Royo5QFZ+YuTmvCxKUh5+XT9mkUlTOCNU25N+o254ex4M70X6WHkbz?=
 =?us-ascii?Q?t2YMQfm2CTOScqgvgrpjx96by+IFCx9ZPG1GwsTyUo7/c+/U3MFEJDuGTUc1?=
 =?us-ascii?Q?WIOdHTA5KfgaEi+TnhCXuJQl3z+LCk5ou+IabqnVP4XFTiXB/exOIfyRBJbr?=
 =?us-ascii?Q?D29t1u9YtX5YgL+e0szTRmL3nCRdu/BCD6WzUy9m9gviEN0bO2eQIaFTNA6k?=
 =?us-ascii?Q?4Lu/axVTvvQTroLkn+2fZ0uw2VA6cvincTnZiEimChqRmfCyHQbIJ1nk7Z5b?=
 =?us-ascii?Q?/7K6Gm5SngnMr603KnPhkOKgc1wdeis5OIJFZ8URXPHizeDymdkjnuBceX9q?=
 =?us-ascii?Q?AMljCM5cEfJ6bJMiweZpl2PJf0AY/zV0Vn/rDLEHTap4waF0tEfPdxZDSt4I?=
 =?us-ascii?Q?f7UWmLywZ/ZTJWsrDpnr/dxlTTbtMUcYwlJW6dweLeYn6X9asOFl6G0oWZt7?=
 =?us-ascii?Q?b1BI7khcmkeQV/y60Np3guLTmLycI2K9WsXfxGoZNAM5DTgfgTnMQCgjfyOV?=
 =?us-ascii?Q?rGdc2ttVi85v4W3IqQCmfYrF9ZsYoByZY5wuPf1GUbZtAJT5ZwxsoNjCP1Bj?=
 =?us-ascii?Q?2Y0y5K0o+cfbL45zV1sAWXw86s1TX707FpLZqUDludRGgv6CjuyOSL2OzJfn?=
 =?us-ascii?Q?AZPG9ewoyl/Tz8VJPUeV0uqR6Be9RW/yJtDuB1XbXyVfmr1bwz2r9osulmEf?=
 =?us-ascii?Q?wiQnYxwHYNpqNX2Hlq/m5vAvUBnCESQN9EjMn52uO4J1TeNmgGTIK1lArQsz?=
 =?us-ascii?Q?fdggRFvdsSkEvU/CV4Y1BhIREo7XI68pjA9T2cUmRW+0dBIA5/BC8zeSeIxn?=
 =?us-ascii?Q?eVbhZJqdAOvJONtGnRFNwkbI3JyfvfK3kz1/EG4YPX67oaXfpYq7b+9Jay9w?=
 =?us-ascii?Q?MfKxc+7n6aVW01LKv4hmsW15hxyoVIGj+MytVU/qoUTUGjqfd61JzPPja/TD?=
 =?us-ascii?Q?O7wZYBQJwamiTk/lLv5u5DcaFmWyXufkXT/yWuCFLnSQs2cwPrS2TyqRCach?=
 =?us-ascii?Q?LKGSISrECKszzmU04cFc2w3n2JxfTOtapehV5fL+/eqVENuSmRt05+sulW3J?=
 =?us-ascii?Q?ieOuD7dsHi2QRuGOqwHsR2+ppjQm4S+qXhCTElxJvAK+K4mxn6o/COWHMGAY?=
 =?us-ascii?Q?ULS/XdunLgExsyamNrpEJi76RnNQdufOT/i3vQYC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5035C001F5EC8241BFC13DA418A171BE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2810e40c-b065-47d6-c7fd-08db88427925
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 10:25:28.4760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8iLMTAVKUHiNuqdk5YyynhbXBXPr0B72n9SGAMis2OhBk3pY7YMT/94cvXvM80NhZNwFNlKWBYvCdMlDN9WrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB6637
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 18-Jul-2023, at 7:10 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> !! External Email
>=20
> On Sun, 16 Jul 2023 17:32:35 +0000
> Ajay Kaher <akaher@vmware.com> wrote:
>=20
>> Thanks Steve, hopefully I will fix all the pending nits in v5.
>> Here is the checkpatch.pl report:
>=20
> Hold off on v5. I hit the following on v4:

OK.

>=20
> [  220.170527] BUG: unable to handle page fault for address: ffffffffffff=
fff0
> [  220.172792] #PF: supervisor read access in kernel mode
> [  220.174618] #PF: error_code(0x0000) - not-present page
> [  220.176516] PGD 13104d067 P4D 13104d067 PUD 13104f067 PMD 0
> [  220.178559] Oops: 0000 [#1] PREEMPT SMP PTI
> [  220.180087] CPU: 3 PID: 35 Comm: kworker/u8:1 Not tainted 6.5.0-rc1-te=
st-00021-gdd6e7af33766-dirty #15
> [  220.183441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.2-debian-1.16.2-1 04/01/2014
> [  220.186629] Workqueue: events_unbound eventfs_workfn
> [  220.188286] RIP: 0010:eventfs_set_ef_status_free+0x17/0x40
> [  220.190091] Code: 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 66 0f 1f 00 0f 1f 44 00 00 48 8b 47 18 48 8b 40 30 48 83 f8 10 74 1b <=
f6> 40 f0 02 74 15 48 8b 47 78 48 85 c0 74 0c c6 40 5a 00 48 c7 40
> [  220.195360] RSP: 0018:ffffa731c0147e20 EFLAGS: 00010287
> [  220.196802] RAX: 0000000000000000 RBX: ffff97ca512ca000 RCX: 000000000=
0000000
> [  220.198703] RDX: 0000000000000001 RSI: ffff97ca52d18010 RDI: ffff97ca5=
12ca000
> [  220.200540] RBP: ffff97ca52cb3780 R08: 0000000000000064 R09: 000000008=
02a0022
> [  220.202324] R10: 0000000000039e80 R11: ffff97cabffd5000 R12: ffff97ca5=
12ca058
> [  220.204012] R13: ffff97ca52cb3780 R14: ffff97ca40153705 R15: ffffffffa=
d5c1848
> [  220.205685] FS:  0000000000000000(0000) GS:ffff97cabbd80000(0000) knlG=
S:0000000000000000
> [  220.207476] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  220.208764] CR2: fffffffffffffff0 CR3: 000000010a01a001 CR4: 000000000=
0170ee0
> [  220.210342] Call Trace:
> [  220.210879]  <TASK>
> [  220.211359]  ? __die+0x23/0x70
> [  220.212036]  ? page_fault_oops+0xa4/0x180
> [  220.212904]  ? exc_page_fault+0xf6/0x190
> [  220.213738]  ? asm_exc_page_fault+0x26/0x30
> [  220.214586]  ? eventfs_set_ef_status_free+0x17/0x40
> [  220.216081]  tracefs_dentry_iput+0x39/0x50
> [  220.217370]  __dentry_kill+0xdc/0x170
> [  220.218581]  dput+0x142/0x310
> [  220.219647]  eventfs_workfn+0x42/0x70
> [  220.220805]  process_one_work+0x1e2/0x3e0
> [  220.222031]  worker_thread+0x1da/0x390
> [  220.223204]  ? __pfx_worker_thread+0x10/0x10
> [  220.224476]  kthread+0xf7/0x130
> [  220.225543]  ? __pfx_kthread+0x10/0x10
> [  220.226735]  ret_from_fork+0x2c/0x50
> [  220.227898]  </TASK>
> [  220.228792] Modules linked in:
> [  220.229860] CR2: fffffffffffffff0
> [  220.230960] ---[ end trace 0000000000000000 ]---
>=20
>=20
> I think I know the issue, and looking to see if I can fix it.


- Is it also reproducible on v3?
- Is it manually reproducible or reproducible using any specific script?

Let me know if I can help.

-Ajay

