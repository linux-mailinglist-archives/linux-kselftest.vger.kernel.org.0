Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB65734B65
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 07:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjFSFih (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 01:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjFSFif (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 01:38:35 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011005.outbound.protection.outlook.com [52.101.47.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9D91AC;
        Sun, 18 Jun 2023 22:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBVTZawKtlH8nnssAUGU8AP8vc9jYoNyUBDtwO50WaQd4c+nESCBD93E9fCVfidGl4itiIs5aNiwA0HoeLBAZGqZJnNIrUR4YCb3NiRiqAoztk8dHvuF+FpWlqsGFXYe5L0SgkHa6wseSSwTDXh5VngfPQv1XSdFkl3GYakJumZuuQj4nHvONCMapXPgAL84j99vlj9IymtmTIP43vxMW38k1Q1/P75JAY8kBv+A3qwk3OanP4mxhRXs3mh8OpEvzvOv00He9kN2xUtdEmixHOJl8DO9GtrTLwNXB2SzqKP4Zr4theB0awIvQgSqMRjG+sB9yFhvPMwUpqCqlS4FKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPrCS0rEYk1Ls5FxHw3IWNaf+mNOjbveEM+XgoGZvow=;
 b=KDmQzy4xKmH1AjuYYa9bjd6BVsdtlKew5K9BSK9OtjglWEVMLPNCRqtMSo7OnONyfBosXiuawrWkWP5VBA94jkrX3krlfugBS/BOhYihzm6ylhU8aYUgw409zb/JYh1lFROvDOishzF79TbcPek1UscfeXKLwXS8We9IgEXUannj4pLcKTI5ILQmhQKxsd0E8tXXP7sGoKyNVMIvrDuIeoJVkjncJfBFGV/J2hXgVTsVRdS7ZmzLIxNJQWkfdzX2GUB1i/IMOsgt6fnl68Arp8UqW77svdx66xoiR8wMc77t6ojbH+OeMf3yaum9uDRIVBppcqU7+bfs+D6X9HSZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPrCS0rEYk1Ls5FxHw3IWNaf+mNOjbveEM+XgoGZvow=;
 b=i1TOlG96xsH9UPSoCg8Z6MXQ17MhLSGOgPs4ajIh5ZhmGHLU5hllmpYU3Rswrs7VlD2/60t9FHIdrzf7p8d+9RzV84DkomUd/bqLqkUBGuuZlcHUwMYzoutTKWaW3FWdXPjLTjo5bUbcLt3q8NegH/6RI4bkViUEgzpiOh6eEZ0=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by IA0PR05MB10142.namprd05.prod.outlook.com (2603:10b6:208:40a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 05:38:25 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 05:38:25 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 00/10] tracing: introducing eventfs
Thread-Topic: [PATCH v3 00/10] tracing: introducing eventfs
Thread-Index: AQHZlGeSoCEyu7THQ0iKwxE3Uhr81a+Rt6wA
Date:   Mon, 19 Jun 2023 05:38:25 +0000
Message-ID: <34E6364B-2B3D-4597-8143-1EEA645B6CDD@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
In-Reply-To: <1685610013-33478-1-git-send-email-akaher@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|IA0PR05MB10142:EE_
x-ms-office365-filtering-correlation-id: f5040ae9-d80a-481a-964b-08db708766d8
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgFVLXOGNrWvAMUuDjEhymYDJCK/4SgK9MGKa9XYAJ8Qxk1VBRwDxcu4U+MGcq9DjkBdsIHNc/JQGgJ1bUg0kp/PY90zeSIgIWNzPLiyLL0/OuKL9qHH1krFWi923d8XRBVO4QgF2lV5B83fNhwww8TGJIvuoI1AMZTY44M4nZUOc9d/0sTo5GOLiXJrUVg+2/6V1tT95M7a00C4mQmyTlKCd2ka/0VSGvactuFeKqHfPY4lFzxW3PJz45D0f+4XQFzP8/foIz3WiiC4aXo0HFo+CJd37vNKUT4F9dtYJ5M4zsRLwIZnIUb1rvsNDYLJHfUvqGmjcFrjgWUGYeuHjQHCeewAhhvvYGgaS1IWGFg4H5081THypVVR60OozJ07Uj16NUsT5SuZESf04eisRALbx9U8fP7nX4suqbu5AMgw14JLY6pzV3tLVau1zu9wVj/B7dB1UyJG+cSPeOqUudngJCSeanHoToTot6UAP2ZzMvLKJOrq9F03G2to3LKoIFuz1v1mxIpvtBoY3wb1TPluodlEN7w7J6FXBAFMOviGuDdqdSlTUb63XThjqs6h+UaLDLnwjuCj34VVugJPcoyaLrru+Xd+DavkEOZ3IIVXZff6APbRBZ2w7oJ+S4sUFpppD4o5jLXSm4dZQEtN6dcvsAZeojoHEQcXy03EI1aNWJWC0wkUgQrg6LR9y20NLFKXmuWDvZFdsfXQodkrTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(186003)(8676002)(8936002)(66946007)(66556008)(64756008)(66446008)(66476007)(5660300002)(76116006)(110136005)(54906003)(4326008)(71200400001)(6486002)(33656002)(316002)(38100700002)(478600001)(41300700001)(36756003)(26005)(53546011)(6506007)(6512007)(91956017)(122000001)(30864003)(38070700005)(86362001)(83380400001)(2906002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G8VCVCzvm8e2EDiRrPzfRHTIO0lNm5a9+uiYmXAoVTBq9E2EWysnqCBIus3k?=
 =?us-ascii?Q?AFWlFVbAAquT0bpsk4ycQb1Eh9BN/z5okaHvuMAiZlYn27ilbnMcsmKz+iDZ?=
 =?us-ascii?Q?9OJwhmS6Kd41Sa5U2hbwqpztTC4SxcLEc1piC14Uqd2Jk0Slg/nbCXC6JJmU?=
 =?us-ascii?Q?SvZIIhLwdGItSyULPGe18Z4juHcRu6b1Dd6qtpAYUa2SzUYYLMP2l4fJ/eVN?=
 =?us-ascii?Q?ux3ZLjoMgw7DzB7ZqLfTIfv+XB4GJVM61s9TtOmwvLlOHjvojbgSj1TzFpNl?=
 =?us-ascii?Q?WgMO0S/6MuSDeT4QaJAZmz2dqQRVAQgRnhNcyuUibnHLRA6X5CLASPvwRigW?=
 =?us-ascii?Q?qox7PWgBgVKWqvPkZwSucnwRtcMCRGh3g+HeJMPMtVgHHxGHvVNMjorPjzSf?=
 =?us-ascii?Q?93S/3II4hlHnVcEY39kh8TGarNQOkmYFlKX2OTlJj0fMOmYVXLsuGyh8qjt5?=
 =?us-ascii?Q?h6H/iSrfFkbSAro/mwGRPerYvouFXYQoZQZ6g7dru74ldtk1UMfeeh7ICFcJ?=
 =?us-ascii?Q?zMlouWO4Z3eB7LdzyW75phhIEDL65Tp0aE+/daF5/UKqQ0LOrk5rccQL8oaR?=
 =?us-ascii?Q?O5loGy7l80xaG6Kw7L337xXw9zx6f2brPmQa2AlWVmKE59xFqwTkPLi6ykND?=
 =?us-ascii?Q?v5vWi6ZSLMYWg2EkM20Kc3IUk+Ym5z29kRYKcmyO4CEd4gxc0TZU8oe+PNHP?=
 =?us-ascii?Q?S7aJ+mtBRltMTRPa6ZA8pbayFfy71XLuf0HR2JD0Rc8FQ3P0Zf1w02dh2d3N?=
 =?us-ascii?Q?FRMh+50AkwY5USpLbPB4Npn6Jp9EMYskvbu3ja+zRHrM+t+P2iY33po6S3u3?=
 =?us-ascii?Q?1kWVCi3+Hsa+Ch/e0KZuDtVBML0WdI2kHlEziUoeMTif9z5NUp0Sx9AeSfa+?=
 =?us-ascii?Q?Q/8adM/rC8TWk277luQoFUhvmZi8nvp5KqGKaH8NLBNd0T/8KWrYHQZE1K8o?=
 =?us-ascii?Q?QDsvrDKLiNodJzcq5GRIf1NPeLiyinwn8yujnojzHWwXpFFm2KqyS4HkRklv?=
 =?us-ascii?Q?7mG1E4JwKa3gjbQvQWLkCbQzB/LCX9m4a6g2hJ5rD+dt3JRl5Cj4TTMXKSWG?=
 =?us-ascii?Q?1v+Xv28CaN/qH+y20evy2XVr1qLb86fYird9VqcY13Q0Q8ODpqqGsjDs4hsO?=
 =?us-ascii?Q?cctpNXtMduyalzeYgFR0fRmlmr8C/WnIt41S3qezjcaWDbX6GBrLOLG8Wdjb?=
 =?us-ascii?Q?XxmUtfaCM6oT/0q8m9timJHe3IFOGTW8JekARnyv7/Ej5xcc8tQkTLz+ZEj1?=
 =?us-ascii?Q?eJShmGIpt/SOQ7IiUWrgtHvoRtPp4Ymp7CjwAvQrMEh7WOUwusTEQN5SPnhV?=
 =?us-ascii?Q?ArP2BeHCf9b8Y2MSP0/uE2YR0K/bWahVuh69Az1lUNFcl9vdKBgPAMs63QF7?=
 =?us-ascii?Q?V0Cj/zFeI6SOMQ4qaOJXUmS52GuCvc6tp6Lgp6415xgabjJ2KLilDAmVww9O?=
 =?us-ascii?Q?J85s97Pdwji8cOn3y4wIJIx/QODz8blpfpzAJ/PeG1MVmb+0DRxqZ3Untly3?=
 =?us-ascii?Q?F7HdFFQBdA2pdwOUhG145c7RjJWxwzZigY6ao8YCjdKH1KKs9WQrAdrrFC5R?=
 =?us-ascii?Q?Z5ALuw233oC5HcVmBF3wnbQBJdtrjrSYVfUhyR/x?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9161CE51403E54439C67F75D7F53E2E6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5040ae9-d80a-481a-964b-08db708766d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 05:38:25.1292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxdb0/jb3JMrTfK+fqlSWBN9vK6RtBv4cLZloIUJLw/ubdY2Wn1y62ZWEb9Xj92HwAL03gKOF+t+zjQC+sViHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR05MB10142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 01-Jun-2023, at 2:30 PM, Ajay Kaher <akaher@vmware.com> wrote:
>=20
> Events Tracing infrastructure contains lot of files, directories
> (internally in terms of inodes, dentries). And ends up by consuming
> memory in MBs. We can have multiple events of Events Tracing, which
> further requires more memory.
>=20
> Instead of creating inodes/dentries, eventfs could keep meta-data and
> skip the creation of inodes/dentries. As and when require, eventfs will
> create the inodes/dentries only for required files/directories.
> Also eventfs would delete the inodes/dentries once no more requires
> but preserve the meta data.
>=20
> Tracing events took ~9MB, with this approach it took ~4.5MB
> for ~10K files/dir.
>=20
> v2:
> Patch 01: new patch:'Require all trace events to have a TRACE_SYSTEM'
> Patch 02: moved from v1 1/9
> Patch 03: moved from v1 2/9
>          As suggested by Zheng Yejian, introduced eventfs_prepare_ef()
>          helper function to add files or directories to eventfs
>          fix WARNING reported by kernel test robot in v1 8/9
> Patch 04: moved from v1 3/9
>          used eventfs_prepare_ef() to add files
>          fix WARNING reported by kernel test robot in v1 8/9
> Patch 05: moved from v1 4/9
>          fix compiling warning reported by kernel test robot in v1 4/9
> Patch 06: moved from v1 5/9
> Patch 07: moved from v1 6/9
> Patch 08: moved from v1 7/9
> Patch 09: moved from v1 8/9
>          rebased because of v3 01/10
> Patch 10: moved from v1 9/9
>=20
> v1:
> Patch 1: add header file
> Patch 2: resolved kernel test robot issues
>         protecting eventfs lists using nested eventfs_rwsem
> Patch 3: protecting eventfs lists using nested eventfs_rwsem
> Patch 4: improve events cleanup code to fix crashes
> Patch 5: resolved kernel test robot issues
>         removed d_instantiate_anon() calls
> Patch 6: resolved kernel test robot issues
>         fix kprobe test in eventfs_root_lookup()
>         protecting eventfs lists using nested eventfs_rwsem
> Patch 7: remove header file
> Patch 8: pass eventfs_rwsem as argument to eventfs functions
>         called eventfs_remove_events_dir() instead of tracefs_remove()
>         from event_trace_del_tracer()
> Patch 9: new patch to fix kprobe test case
>=20
> fs/tracefs/Makefile                           |   1 +
> fs/tracefs/event_inode.c                      | 757 ++++++++++++++++++
> fs/tracefs/inode.c                            | 124 ++-
> fs/tracefs/internal.h                         |  25 +
> include/linux/trace_events.h                  |   1 +
> include/linux/tracefs.h                       |  49 ++
> kernel/trace/trace.h                          |   3 +-
> kernel/trace/trace_events.c                   |  78 +-
> .../ftrace/test.d/kprobe/kprobe_args_char.tc  |   4 +-
> .../test.d/kprobe/kprobe_args_string.tc       |   4 +-
> 10 files changed, 994 insertions(+), 52 deletions(-)
> create mode 100644 fs/tracefs/event_inode.c
> create mode 100644 fs/tracefs/internal.h
>=20


Hi Steve, below is the ftracetest results with v3 of eventfs:

root@photon-6 [ ~/linux-6.3-rc5/tools/testing/selftests/ftrace ]# ./ftracet=
est
=3D=3D=3D Ftrace unit tests =3D=3D=3D
[1] Basic trace file check [PASS]
[2] Basic test for tracers [PASS]
[3] Basic trace clock test [PASS]
[4] Basic event tracing check [PASS]
[5] Change the ringbuffer size [PASS]
[6] Snapshot and tracing setting [UNSUPPORTED]
[7] trace_pipe and trace_marker [PASS]
[8] Test ftrace direct functions against tracers [UNRESOLVED]
[9] Test ftrace direct functions against kprobes [UNRESOLVED]
[10] Generic dynamic event - add/remove eprobe events [PASS]
[11] Generic dynamic event - add/remove kprobe events [PASS]
[12] Generic dynamic event - add/remove synthetic events [UNSUPPORTED]
[13] Generic dynamic event - selective clear (compatibility) [UNSUPPORTED]
[14] Event probe event parser error log check [PASS]
[15] Generic dynamic event - generic clear event [UNSUPPORTED]
[16] Generic dynamic event - check if duplicate events are caught [PASS]
[17] event tracing - enable/disable with event level files [PASS]
[18] event tracing - restricts events based on pid notrace filtering [PASS]
[19] event tracing - restricts events based on pid [PASS]
[20] event tracing - enable/disable with subsystem level files [PASS]
[21] event tracing - enable/disable with top level files [PASS]
[22] Test trace_printk from module [UNRESOLVED]
[23] event filter function - test event filtering on functions [FAIL]
[24] ftrace - function graph filters with stack tracer [UNSUPPORTED]
[25] ftrace - function graph filters [PASS]
[26] ftrace - function trace with cpumask [PASS]
[27] ftrace - test for function event triggers [PASS]
[28] ftrace - function glob filters [PASS]
[29] ftrace - function pid notrace filters [PASS]
[30] ftrace - function pid filters [PASS]
[31] ftrace - stacktrace filter command [PASS]
[32] ftrace - function trace on module [UNRESOLVED]
[33] ftrace - function profiler with function tracing [UNSUPPORTED]
[34] ftrace - function profiling [UNSUPPORTED]
[35] ftrace - test reading of set_ftrace_filter [PASS]
[36] ftrace - Max stack tracer [UNSUPPORTED]
[37] ftrace - test for function traceon/off triggers [PASS]
[38] ftrace - test tracing error log support [PASS]
[39] Test creation and deletion of trace instances while setting an event [=
PASS]
[40] Test creation and deletion of trace instances [PASS]
[41] Kprobe dynamic event - adding and removing [PASS]
[42] Kprobe dynamic event - busy event check [PASS]
[43] Kprobe event char type argument [PASS]
[44] Kprobe event with comm arguments [PASS]
[45] Kprobe event string type argument [PASS]
[46] Kprobe event symbol argument [PASS]
[47] Kprobe event argument syntax [PASS]
[48] Kprobe dynamic event with arguments [PASS]
[49] Kprobes event arguments with types [PASS]
[50] Kprobe event user-memory access [PASS]
[51] Kprobe event auto/manual naming [PASS]
[52] Kprobe dynamic event with function tracer [UNSUPPORTED]
[53] Kprobe dynamic event - probing module [UNRESOLVED]
[54] Create/delete multiprobe on kprobe event [PASS]
[55] Kprobe event parser error log check [PASS]
[56] Kretprobe dynamic event with arguments [PASS]
[57] Kretprobe dynamic event with maxactive [PASS]
[58] Kretprobe %return suffix test [PASS]
[59] Register/unregister many kprobe events [PASS]
[60] Kprobe events - probe points [FAIL]
[61] Kprobe profile [PASS]
[62] Uprobe event parser error log check [PASS]
[63] test for the preemptirqsoff tracer [UNSUPPORTED]
[64] Meta-selftest: Checkbashisms [UNRESOLVED]
[65] Test wakeup RT tracer [UNSUPPORTED]
[66] Test wakeup tracer [UNSUPPORTED]
[67] event trigger - test inter-event histogram trigger expected fail actio=
ns [UNSUPPORTED]
[68] event trigger - test field variable support [UNSUPPORTED]
[69] event trigger - test inter-event combined histogram trigger [UNSUPPORT=
ED]
[70] event trigger - test multiple actions on hist trigger [UNSUPPORTED]
[71] event trigger - test inter-event histogram trigger onchange action [UN=
SUPPORTED]
[72] event trigger - test inter-event histogram trigger onmatch action [UNS=
UPPORTED]
[73] event trigger - test inter-event histogram trigger onmatch-onmax actio=
n [UNSUPPORTED]
[74] event trigger - test inter-event histogram trigger onmax action [UNSUP=
PORTED]
[75] event trigger - test inter-event histogram trigger snapshot action [UN=
SUPPORTED]
[76] event trigger - test inter-event histogram trigger eprobe on synthetic=
 event [UNSUPPORTED]
[77] event trigger - test synthetic event create remove [UNSUPPORTED]
[78] event trigger - test inter-event histogram trigger trace action with d=
ynamic string param [UNSUPPORTED]
[79] event trigger - test inter-event histogram trigger trace action with d=
ynamic string param [UNSUPPORTED]
[80] event trigger - test synthetic_events syntax parser errors [UNSUPPORTE=
D]
[81] event trigger - test synthetic_events syntax parser [UNSUPPORTED]
[82] event trigger - test inter-event histogram trigger trace action [UNSUP=
PORTED]
[83] event trigger - test event enable/disable trigger [PASS]
[84] event trigger - test trigger filter [PASS]
[85] event trigger - test histogram expression parsing [UNSUPPORTED]
[86] event trigger - test histogram modifiers [UNSUPPORTED]
[87] event trigger - test histogram parser errors [UNSUPPORTED]
[88] event trigger - test histogram trigger [UNSUPPORTED]
[89] event trigger - test multiple histogram triggers [UNSUPPORTED]
[90] event trigger - test snapshot-trigger [UNSUPPORTED]
[91] event trigger - test stacktrace-trigger [PASS]
[92] trace_marker trigger - test histogram trigger [UNSUPPORTED]
[93] trace_marker trigger - test snapshot trigger [UNSUPPORTED]
[94] trace_marker trigger - test histogram with synthetic event against ker=
nel event [UNSUPPORTED]
[95] trace_marker trigger - test histogram with synthetic event [UNSUPPORTE=
D]
[96] event trigger - test traceon/off trigger [PASS]
[97] (instance)  Basic test for tracers [PASS]
[98] (instance)  Basic trace clock test [PASS]
[99] (instance)  Change the ringbuffer size [PASS]
[100] (instance)  Snapshot and tracing setting [UNSUPPORTED]
[101] (instance)  trace_pipe and trace_marker [PASS]
[102] (instance)  event tracing - enable/disable with event level files [PA=
SS]
[103] (instance)  event tracing - restricts events based on pid notrace fil=
tering [PASS]
[104] (instance)  event tracing - restricts events based on pid [PASS]
[105] (instance)  event tracing - enable/disable with subsystem level files=
 [PASS]
[106] (instance)  event filter function - test event filtering on functions=
 [FAIL]
[107] (instance)  ftrace - test for function event triggers [PASS]
[108] (instance)  ftrace - function pid notrace filters [PASS]
[109] (instance)  ftrace - function pid filters [PASS]
[110] (instance)  ftrace - stacktrace filter command [PASS]
[111] (instance)  ftrace - test for function traceon/off triggers [PASS]
[112] (instance)  event trigger - test event enable/disable trigger [PASS]
[113] (instance)  event trigger - test trigger filter [PASS]
[114] (instance)  event trigger - test histogram modifiers [UNSUPPORTED]
[115] (instance)  event trigger - test histogram trigger [UNSUPPORTED]
[116] (instance)  event trigger - test multiple histogram triggers [UNSUPPO=
RTED]
[117] (instance)  trace_marker trigger - test histogram trigger [UNSUPPORTE=
D]
[118] (instance)  trace_marker trigger - test snapshot trigger [UNSUPPORTED=
]


# of passed:  65
# of failed:  3
# of unresolved:  6
# of untested:  0
# of unsupported:  44
# of xfailed:  0
# of undefined(test bug):  0

These results are same with/without eventfs.

-Ajay

