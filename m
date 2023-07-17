Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BB755ADD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 07:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGQFYx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 01:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQFYw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 01:24:52 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012004.outbound.protection.outlook.com [40.93.200.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2FE6B;
        Sun, 16 Jul 2023 22:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8rHJjImN197R+81+Vm7SWvg8EcHL6aEnG/t2uuXwvT1hRLQo2evLsbOAjPPpW/QoZMe0DBd83fjRwWU1O1l9aGe1jDJDGdMgnjq+KIDFalF+Wz/7hUO/F7p0wHhQjkrvx321rB1QmCPnlkGsfRnAg4xpd18bwGtb4sH463Y5jobtPr5PSVdw2fQUfoxhV44N8XPq4XnBDcFZ9p56Ue+tLlqxhlCmjWfsAs0jyQDg++mXpUuS24jZJ+Qod3GaJZDjmkNW2C0YDI+14ROxl+iUHkI29CHw+M/Dj3+3+qJqy4r/Z5W6bJJkdvjKCY/O7q8c012xu55tr402hKIDKS2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T6cwyN5SiGLSJefk4MOugJ31zTWU4k59Ujt7VRSPm8=;
 b=azHHwewMesVnasPbxvHqy3Jsep2vprloPee5BoJzLr7X8kMHG5FKWH12vzyPpdN2+f2eREbVDCPsefxpFrhBcto13Atv1cI+rlEFpEABvMiIyB/3eqQmSCUHyQTmpXLJOahhoqbPHHxi+jZCSOcpADnAWbCSX/mUV0YdVcfhR+KmUK2v7ZvZrGlHha5e9ufH0DJF+GhAQvxdR6x+42EdSZm4RrWZ6lWUPS6IX0HytegcEU4wnGCMXJDVoE4Hr3Gf74uLUyvlNiXsCiBs97e7lcKTsJ8mot5wihEI0eIMV2YVzGFIG6HTJo9ecmPifO+kcK/1AHi4PZeQTBPLL5wurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T6cwyN5SiGLSJefk4MOugJ31zTWU4k59Ujt7VRSPm8=;
 b=0bpMp1wFtVZ6aN8Wpa5Nbo0w77Sh+JVuXa8fnZ3gL/oUYI450SfrIPS5J0Jp8nKKUGkhWdFvZJhZ89JJlwHmXRHtC2aeIc18DX8wRq4tFXN7XlxrhfhpINj8OReLut+J3P9ZK7Cw6L1X2Nmbp+G/rSi+FcU0/modol2sRbXfACc=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SJ0PR05MB8727.namprd05.prod.outlook.com (2603:10b6:a03:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 05:24:44 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 05:24:44 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Nadav Amit <namit@vmware.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 10/10] test: ftrace: Fix kprobe test for eventfs
Thread-Topic: [PATCH v4 10/10] test: ftrace: Fix kprobe test for eventfs
Thread-Index: AQHZtX3uYwr5QtXjSUioorbPK7UQsq+4jWoAgAC1XYCABDArAA==
Date:   Mon, 17 Jul 2023 05:24:43 +0000
Message-ID: <54F18849-4C39-4F30-A3D7-969F14EA3810@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
 <1689248004-8158-11-git-send-email-akaher@vmware.com>
 <20230713223758.31a1e391@rorschach.local.home>
 <20230714222705.bc38f83d857473656a45d441@kernel.org>
In-Reply-To: <20230714222705.bc38f83d857473656a45d441@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|SJ0PR05MB8727:EE_
x-ms-office365-filtering-correlation-id: c889786a-2bca-4665-892b-08db868620f1
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aLvJqNhLh9qQZmMuf+MZfTxx7JJKqaTGcFxfR96xNXAjLnKSOid8waUDrU/Jqj9wJhMfMcJsfC3P5SPlQUxRkR3/kOayXgDWTa3BXPAAMYTDtViCMv/T/GB08mpKtYiCDSz75KBS3RoeqFOO5yNZu52n776XIHQgH702zJwqjasUIxYNWBXYi5/1Mm7vxgoH3cUvB9IE/AxaXINkQDHO7axNtTls2rNiUYfbOoJLBQ/YKCfhmc4kPbIO7aXNJi2kSuIM3CQVDbdJGNX0z+mDJ/o+T8BOSNIv21EiRrqjfWNsN3dJj9NRcTnBf/suqHE3Bf7mNc4uWvujhQgWL7HlRLtjDryh6ijLpwLS362nqtqgfjajKti0SO5am5zbRfp1REVIY7xVcS0FA5+YeTDU0cYvmGRmd06JxBUdDzSV9HwvR02IuJc37Edo313ZAJunDZAvUFIhKjXxv1UUikWn4ceSZzYGmsXfM9zeb+WkXsME3lCgH1oN8BFUoZTVOQJbgYtJMG5fOLh2HIEqsRSREwtdV0WX2BlS9ukcSKv4dgyjJP/LURzpE3cgpT07nVjfB+q6Uav3VtY32Zh8KAgK6HdmwHVH02rj8bzdrURbJMO5usqh8tNMJPsKmiidv2e+Z0+KIDZ4xD9TW4Qsd5rIaetimoQCB/bhlllOGkhAz4c/TdsDcg6tOHrmZK3dJfcGx8GbjpYNBmLFzzeEVCjkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(71200400001)(33656002)(107886003)(6506007)(83380400001)(38100700002)(26005)(186003)(53546011)(110136005)(478600001)(38070700005)(6512007)(6486002)(54906003)(7416002)(8676002)(41300700001)(66476007)(66446008)(8936002)(2906002)(66556008)(66946007)(316002)(4326008)(5660300002)(36756003)(64756008)(2616005)(86362001)(91956017)(76116006)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j0/NbMoxch6vg9iYH4GIkCORPovtzKYTGHLZOaSeFELgCrSAAXZrjDSWkgpI?=
 =?us-ascii?Q?Vk+QHHJZjslqsiIMy9paE/09OIT+HaogYWZcofTZvcwT326hptpmceImpy4f?=
 =?us-ascii?Q?57VpVXaYqJTzYF/K3eQj4ToejFdx6QrgPRKZOCq0bfKBuOKdFF96iyIX2X2p?=
 =?us-ascii?Q?KQs8UPIDlPims+c672RT27QJOHkG36DRYiS7HwX1XuZLcmgSCtsoHaM2A9Dt?=
 =?us-ascii?Q?RMY/iMhYPPskVHgtPXaWqgv6BMnoZdccTSYDwdacQ6abey3y1tI8Iu+BtAek?=
 =?us-ascii?Q?rOWfKd32nCJoe8onuViQnN7Rg7pvlNxukuS9Kd9zAwurNFhPE0hKv3Re8DKO?=
 =?us-ascii?Q?erBe9w96PokMCgUnRkREm7fQY2lMYZtz7Ba/6FSGcPYCfRYaP93dUoR/RXDa?=
 =?us-ascii?Q?ZOGJHe/ioiemWVMjynFk9jJgc6eWLrvalnyjtB3RlsLqnYn0rxEVSJ1bxjy4?=
 =?us-ascii?Q?jRR7DzHoI690Cjo1WHTOpN8HG4CekXQ5A4I7FH05Xqxff+QbVo5NXrAFpT2r?=
 =?us-ascii?Q?85px/CFmfyBQnHW6eb0IkheO3sWHGb8IJYNsVa/zAgH71VmhoJS7hSZcksBG?=
 =?us-ascii?Q?UgWUxPxie8xqSfj+hITZEdsq2BqXYsnr77IoRAbiX3PR/ZHCNj7cIKajbeLo?=
 =?us-ascii?Q?KMbeqtnln510JR/rQJ82ark1yW4zFIsAgFVIxElr0bebfDuqRS5XAWViN08A?=
 =?us-ascii?Q?Z6g7oiRcf0uOqHh3XDFM7X/vHgd4CaZdpJDM1n+eQf1lwjd3tIyKLN6wB6V+?=
 =?us-ascii?Q?b7APKQe6GzdikcLQF7+9DEBwZ/rN/KyWVPLmpoZTRReuwgUHWzIH0SqRej30?=
 =?us-ascii?Q?o17KTYEYLZZ0jJhI+sAfofUS3OyfX4gPckYHxs4o81EI+IFbgtiVu08uI8GF?=
 =?us-ascii?Q?exhaRkT9oYOVZolByjcyDhIs4C7r6h4h5RpqeD86Gb8EKO13+c38+b3SN18X?=
 =?us-ascii?Q?k5BNqYmrykCNfLvgsIN4YpGcbqvR4XmEn6z6l+vLqgluhp9zP0tlE1x9zVDP?=
 =?us-ascii?Q?KLt6E1g88T5H36QIzEcJSVjUPbJaqAm1Ii2HEBLkWNn1l34Owi7YdmVQms60?=
 =?us-ascii?Q?G4fvwoUCIHsdLr9H6z937Ps2y9YY8vM/BfVZUnF6OK0zIPI/EqPxajgoP3SH?=
 =?us-ascii?Q?s6Y7/eARoXZnBaq1CptRRmtFu4yXEW6EqNlxErAqBOvVuv6lhA0LRsAcXEBL?=
 =?us-ascii?Q?aTCKmCapi39bNzHBsPRuthG1M6ycA/t9eqlHDUWbjTxhaBsHlY55FfEw0ZQL?=
 =?us-ascii?Q?aJKFMf61sxv+ppAEAPA3rvge8goMPIvohxTBdKjDg++yTFXptZO3Qssbwwp0?=
 =?us-ascii?Q?AtkImHd+GOweKJ2vMUyPna4f2+1EKJVoxUD1Lp7Da6HwzFLeY+hz5tw0+l/9?=
 =?us-ascii?Q?2kbtssEnRAeZjnnKGOXVtkF1yjQFV0XZS+STwZBlW3gIGl0wLuA1yB3kzJi3?=
 =?us-ascii?Q?ZKIP986W6U4O033X7OACyeMvf7EzXuKvZJYkYBHAtCc4rN0NVKo7/Q/zNYDN?=
 =?us-ascii?Q?COSGP1JVYXlwtt6H4QUdY7oo0i7calehcqSk1I/yTPsV3fkoXA3WdJeHha5A?=
 =?us-ascii?Q?6pw6hhQYB3IvH3QXyXew8IdAVj5F25uL5d3V4Z3t?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64D3AF4A239B1C4DBEF9C20E5E6D1538@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c889786a-2bca-4665-892b-08db868620f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 05:24:43.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KA4BnsrUPFxdrSR/Nix27UHIe8ahYi6sE5mXC5uTSlwKLuxtB7PfH1vnFfstyYktX+cE9cGr5sDAlVyva/wxLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 14-Jul-2023, at 6:57 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>=20
> !! External Email
>=20
> On Thu, 13 Jul 2023 22:37:58 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>> On Thu, 13 Jul 2023 17:03:24 +0530
>> Ajay Kaher <akaher@vmware.com> wrote:
>>=20
>>> kprobe_args_char.tc, kprobe_args_string.tc has validation check
>>> for tracefs_create_dir, for eventfs it should be eventfs_create_dir.
>>>=20
>>> Signed-off-by: Ajay Kaher <akaher@vmware.com>
>>> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>> Tested-by: Ching-lin Yu <chinglinyu@google.com>
>>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>=20
>> As this patch as is will break when running on older kernels, I was
>> wondering if we should do this instead?
>=20
> +1 since the latest kselftest is used also for checking the older
> stable kernels, the test case has to check the environment and
> change the parameter (or make it unsupported for new feature)
> So below looks good to me.

+1, many ftrace tests are unsupported in my setup and may few require
changes, not sure. Does any auto job takes care of this?

- Ajay

>>=20
>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_ch=
ar.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
>> index 285b4770efad..ff7499eb98d6 100644
>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
>> @@ -34,14 +34,19 @@ mips*)
>> esac
>>=20
>> : "Test get argument (1)"
>> -echo "p:testprobe tracefs_create_dir arg1=3D+0(${ARG1}):char" > kprobe_=
events
>> +if grep -q eventfs_add_dir available_filter_functions; then
>> +  DIR_NAME=3D"eventfs_add_dir"
>> +else
>> +  DIR_NAME=3D"tracefs_create_dir"
>> +fi
>> +echo "p:testprobe ${DIR_NAME} arg1=3D+0(${ARG1}):char" > kprobe_events
>> echo 1 > events/kprobes/testprobe/enable
>> echo "p:test $FUNCTION_FORK" >> kprobe_events
>> grep -qe "testprobe.* arg1=3D't'" trace
>>=20
>> echo 0 > events/kprobes/testprobe/enable
>> : "Test get argument (2)"
>> -echo "p:testprobe tracefs_create_dir arg1=3D+0(${ARG1}):char arg2=3D+0(=
${ARG1}):char[4]" > kprobe_events
>> +echo "p:testprobe ${DIR_NAME} arg1=3D+0(${ARG1}):char arg2=3D+0(${ARG1}=
):char[4]" > kprobe_events
>> echo 1 > events/kprobes/testprobe/enable
>> echo "p:test $FUNCTION_FORK" >> kprobe_events
>> grep -qe "testprobe.* arg1=3D't' arg2=3D{'t','e','s','t'}" trace
>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_st=
ring.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.t=
c
>> index a4f8e7c53c1f..a202b2ea4baf 100644
>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
>> @@ -37,14 +37,19 @@ loongarch*)
>> esac
>>=20
>> : "Test get argument (1)"
>> -echo "p:testprobe tracefs_create_dir arg1=3D+0(${ARG1}):string" > kprob=
e_events
>> +if grep -q eventfs_add_dir available_filter_functions; then
>> +  DIR_NAME=3D"eventfs_add_dir"
>> +else
>> +  DIR_NAME=3D"tracefs_create_dir"
>> +fi
>> +echo "p:testprobe ${DIR_NAME} arg1=3D+0(${ARG1}):string" > kprobe_event=
s
>> echo 1 > events/kprobes/testprobe/enable
>> echo "p:test $FUNCTION_FORK" >> kprobe_events
>> grep -qe "testprobe.* arg1=3D\"test\"" trace
>>=20
>> echo 0 > events/kprobes/testprobe/enable
>> : "Test get argument (2)"
>> -echo "p:testprobe tracefs_create_dir arg1=3D+0(${ARG1}):string arg2=3D+=
0(${ARG1}):string" > kprobe_events
>> +echo "p:testprobe ${DIR_NAME} arg1=3D+0(${ARG1}):string arg2=3D+0(${ARG=
1}):string" > kprobe_events
>> echo 1 > events/kprobes/testprobe/enable
>> echo "p:test $FUNCTION_FORK" >> kprobe_events
>> grep -qe "testprobe.* arg1=3D\"test\" arg2=3D\"test\"" trace
>>=20
>> -- Steve
>>=20
>>> ---
>>> .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 4 ++--
>>> .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 4 ++--
>>> 2 files changed, 4 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_c=
har.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
>>> index 285b4770efad..523cfb64539f 100644
>>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
>>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
>>> @@ -34,14 +34,14 @@ mips*)
>>> esac
>>>=20
>>> : "Test get argument (1)"
>>> -echo "p:testprobe tracefs_create_dir arg1=3D+0(${ARG1}):char" > kprobe=
_events
>>> +echo "p:testprobe eventfs_add_dir arg1=3D+0(${ARG1}):char" > kprobe_ev=
ents
>>> echo 1 > events/kprobes/testprobe/enable
>>> echo "p:test $FUNCTION_FORK" >> kprobe_events
>>> grep -qe "testprobe.* arg1=3D't'" trace
>>>=20
>>> echo 0 > events/kprobes/testprobe/enable
>>> : "Test get argument (2)"
>>> -echo "p:testprobe tracefs_create_dir arg1=3D+0(${ARG1}):char arg2=3D+0=
(${ARG1}):char[4]" > kprobe_events
>>> +echo "p:testprobe eventfs_add_dir arg1=3D+0(${ARG1}):char arg2=3D+0(${=
ARG1}):char[4]" > kprobe_events
>>> echo 1 > events/kprobes/testprobe/enable
>>> echo "p:test $FUNCTION_FORK" >> kprobe_events
>>> grep -qe "testprobe.* arg1=3D't' arg2=3D{'t','e','s','t'}" trace
>>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_s=
tring.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.=
tc
>>> index a4f8e7c53c1f..b9f8c3f8bae8 100644
>>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.t=
c
>>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.t=
c
>>> @@ -37,14 +37,14 @@ loongarch*)
>>> esac
>>>=20
>>> : "Test get argument (1)"
>>> -echo "p:testprobe tracefs_create_dir arg1=3D+0(${ARG1}):string" > kpro=
be_events
>>> +echo "p:testprobe eventfs_add_dir arg1=3D+0(${ARG1}):string" > kprobe_=
events
>>> echo 1 > events/kprobes/testprobe/enable
>>> echo "p:test $FUNCTION_FORK" >> kprobe_events
>>> grep -qe "testprobe.* arg1=3D\"test\"" trace
>>>=20
>>> echo 0 > events/kprobes/testprobe/enable
>>> : "Test get argument (2)"
>>> -echo "p:testprobe tracefs_create_dir arg1=3D+0(${ARG1}):string arg2=3D=
+0(${ARG1}):string" > kprobe_events
>>> +echo "p:testprobe eventfs_add_dir arg1=3D+0(${ARG1}):string arg2=3D+0(=
${ARG1}):string" > kprobe_events
>>> echo 1 > events/kprobes/testprobe/enable
>>> echo "p:test $FUNCTION_FORK" >> kprobe_events
>>> grep -qe "testprobe.* arg1=3D\"test\" arg2=3D\"test\"" trace


