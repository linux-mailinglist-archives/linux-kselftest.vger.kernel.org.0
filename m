Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B53755015
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGPRcp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jul 2023 13:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGPRco (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jul 2023 13:32:44 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012000.outbound.protection.outlook.com [40.93.200.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D1E58;
        Sun, 16 Jul 2023 10:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk1QCtTre+KAsO+86fXd2vhzXeF+klpPIVanwNL54Iwgz4EdwQj8vf7qjlCYv9S8DMcsGbItZrjHkjGRG6eDbam20R91gUpOEvKrasTh7csVsxzIt68HUGhl0pvFD8m/19/Ked4nRZb3Hd/U8/i8iXkZrHZq4meTEvQdm5yC0qa1iCiKEWy2b4kR8v0oi/uhVqpl2FaDLkyzsGxm3x3n3ItaMrt0viGOE1xI5vPZJ/h4r819wR05n5bfQyKbkIX0rbRZTVyl3E2BSHiJdLX3Pr6z0DgNodVimhSguv9pggioEkbgI1SSi8MoeQ0wA2LYVzWIfvhGTOXCnh/XY5WRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ2tQpiVrIrX+kpKpTLdRj80WnGQFnXUbzeDkKydQVs=;
 b=lK7js/pDRvPDsymsmddWS1cNragOHzcxfrIZ12NF7bh3Zm2VAZrxNKt0d/7IEuY93o+BDEs92k2Mstm8nUh25lstMd8vz/Xker+aRBTmJqQTPjibdLiMIVOpLsl8WYXl8LfZ0yLkLR//7XxTjGN0JZ9Ci//aInxbOaEOIRXUSQ5TmrvqS9U3FgbhC2LeXweOGHG+jmCDhryK4omg50J1/Gih+rNzL9qdryleyqoF1RV15R7unqpSs2XZDV7j9d03QyTny5FeohS+/6QTHpai/pgAZB/09ZJ6ZLpAtvlIZWRrt/YMzprmps+o8OlD/XLmT2z7afKnBksEFE/bbVfX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ2tQpiVrIrX+kpKpTLdRj80WnGQFnXUbzeDkKydQVs=;
 b=c/fcCCKatKOmgunIsoR9yZzGncK2dSy4wAbwXq6OzyhciCldPllN1k0jclaIvbaH3uaXYYQrK3x6u/gss95V7B+vQ31mJRb2DubEYNfYXrOnhsyk9VJm8ySuOorpE3S1J2cLy4F3QT//HBHjrrFrLe+QFlHFR9+fe1fC/0Fmexw=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by LV8PR05MB10325.namprd05.prod.outlook.com (2603:10b6:408:188::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 17:32:36 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Sun, 16 Jul 2023
 17:32:36 +0000
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
Thread-Index: AQHZtX3ozc4V8XrumUqju4s3WlXUgK+54mYAgALJloA=
Date:   Sun, 16 Jul 2023 17:32:35 +0000
Message-ID: <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
 <20230714185824.62556254@gandalf.local.home>
In-Reply-To: <20230714185824.62556254@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|LV8PR05MB10325:EE_
x-ms-office365-filtering-correlation-id: 433fb2f6-b412-4ef2-e8a0-08db8622a506
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3LjCH1iTKYRWyCDzqWfYyJA7L/X7b3SFe52D4YqSWNGHyCGTlEkJe95PMKgcLET2kRtiHf2WxAh/gH+TxvRrS9T08Y9QrzcKPo1zYNuXq7nGb6jD/Zk1FHtVwca65v6Z7i9d76ZCCsjjUWLhZeNcUy4Y/j9fpQlicLkYG8veYVwswLcgjN9VOQBoJhizek6BHjoFKjsbFIezUqS/j474LFcmw4BES26aVMAuF2+aSmQYx3IFaBjEB5U4FWJ4AnYndZ2pJkKBCDsVvPMVDCBtM9i+jPcApvb5SO3+lLk4NfbNwev2Slsx2kutuif4SYAr8bhJwmQjyK/RSWTb8XnSDfWDHwIGgNEPmwyiBrMU0s7RtbsJSTDL/f1ENtun6x4AOw2PX3OjyCf/02MLmEE8SrefvhWSWRxKRghdHU/7GzchfF0V5R4CrsD5jM6JhnoZV/ctpp3kmoOQ9SGfTuxO+7+dC9q7p8B2/j2qJd+WaX6MeSSvwlGvX3aSongfeVlPdxmuDsqjsAijzaBlrluOCT9oNP6FfM1JjMrAQN87DffkPt2A6qwhSI7kwW0EaFUpGgMvJG02grSEojFDJK//U8dIvttCV+PcR7UEOC7dra/ezHv5JzFepXzEcw4YRJkdifvB5MsmW5TPHzlGp7igZAIgYT58Rz93ePQsA9KhHsejGPS6ItT9QGsOzaJjd4WYMOGcfaVEbvFo40R9C/Kypg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(478600001)(71200400001)(6486002)(91956017)(54906003)(186003)(53546011)(6506007)(36756003)(26005)(6512007)(107886003)(2906002)(76116006)(316002)(41300700001)(66446008)(64756008)(6916009)(4326008)(66946007)(66476007)(5660300002)(7416002)(8936002)(8676002)(66556008)(38100700002)(122000001)(86362001)(38070700005)(2616005)(83380400001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b5XgC82tlYbvhEXIG3olTYr5lw3YHABbsW1Eai3phXt1gCaMnKfxqg/A5HC1?=
 =?us-ascii?Q?FJfES356ffN6/7igqi7B9FYtL6CxWdJrdn4OxmTgO+OT1xWCXrIDXC590Z+V?=
 =?us-ascii?Q?SzOxO0XKQMwm26Yi3XmKtgv/xjN2YjJ22uwOnGJI24y0KFe2Ru4672H5+bNr?=
 =?us-ascii?Q?fUHiSrDk5UZCU8tokAmP9qLUYvl40iUe87oGKH+RAYlIoBMebpe8j/IJv2lW?=
 =?us-ascii?Q?c1270L8054LA1uFL7j3ppklMGtL5oZMs37+o1hSNE9/WeH7dlhjMaVhwQVo3?=
 =?us-ascii?Q?aoA1HjTA+ACWcuvh/BXwZhOcA3COkgXOrKTOZp1OBZ+fIUgzg7MUUfvkAthk?=
 =?us-ascii?Q?HUZQtqwHf+1kVd2O6APfxgiFaQ/5mNSyeSlc4JOsGVbjIKW5FOOiMYhmsJIl?=
 =?us-ascii?Q?y+YUgX/mBxBKpJipLVlG4bebF70L5sMa+YKOUI/LRbHxaxrjTmP/Kl8DWmFm?=
 =?us-ascii?Q?u7wYW+TO3odOZUMwCs5YDrtstat4C0KcTuuYjtqr3Xh2lfHYSbFnRdFVmfDi?=
 =?us-ascii?Q?ArELaah7+SFz7qfhT53pgIvWz47rzw/b/nGhMSGlgn5onyIsABt3Bghxsoxq?=
 =?us-ascii?Q?ZyT8n1ljR/cFkagBMGZIgC7apxYCMoA/PyuYZdEyR8zXJl6A+zPdCvh/GCOr?=
 =?us-ascii?Q?elWMKZtf2aKBWbufMblAuABwcaAvUWMgpB20Es3lf9buoV0fEgqvSRVff+yN?=
 =?us-ascii?Q?DgHQ+BVDSUyMWmOMo7yefXitmMkkVo4TMnX2F+Jw9uZ2/7654o2dlF4Kei+4?=
 =?us-ascii?Q?FcAhTEgTtI3IJhrBJ08E7zOikk1sA6lvP9XO5nqVy10HjUKwN2LWdzXCxw51?=
 =?us-ascii?Q?pjFRAUqY8l55w6jOiRGtTNr/nJf7Vpw+y++hUZOddpLQrku45iC0lAIGZPfb?=
 =?us-ascii?Q?npEXn40Aco6cf/H0pIjBq+EiZ8wbeI/Sdsfkdlo6lefQewIKEPiFOVorIsF0?=
 =?us-ascii?Q?xERbZIsIqSjN5xi6dEH5S14bZLGPCmi/8JNEbKSXMZacUM4wEcB0hh/OvzKs?=
 =?us-ascii?Q?IrPtjWDttaoxI1k5JLcTjUuG73yPj6QmeR8zz7Ih7KthpocjUfgYIwzzurVw?=
 =?us-ascii?Q?oClRw0cFlj1Af2ah0WN4TeP/fXWyspWVHeeiq+00pATz1wgRaYTHRCzScT7d?=
 =?us-ascii?Q?KCT8MdcJfl5FPunnyTjyyRpE1PgiKD7j/seDHoGC337MdbYhc1NOu7p0wd99?=
 =?us-ascii?Q?ShNNzZKCwdk2Mx0Y8EGm8rUhLOawGWsFcBU1ln3YG/rXO8b7Fu+x8houg3Ph?=
 =?us-ascii?Q?hLxz4hVZzGVLpqagmv++N+QvVt4NCu2rmDrqq4eJwYfLBgZarB9TwLgIo2I8?=
 =?us-ascii?Q?8W4fnXDff+3bTxa56Q2W6vStHKSwHfFWU38YsID028OnQWepZBi+AnFNUrpU?=
 =?us-ascii?Q?N7ULRH4aloxncOwklIH/czUX0z8aHYbtHpVed8Los0NYPd3qO26x40tY0A6s?=
 =?us-ascii?Q?Dz1U+hJkGUx3Gj8N44RxAJtfouBuidfH75v+BQZs1OgYoAp0VbBhIYaiFLS8?=
 =?us-ascii?Q?H1l0WGnD13uBKSNEk8PooLniG42cq9zdZ7AJY7zh2I1F7Oa274mLag2Y5ncV?=
 =?us-ascii?Q?nutPJTlVcT6/duysawqdshcfkIWzrIP0QyP4+OuY?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BB0E57FA5F00844A7EAA72E131F0CCD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433fb2f6-b412-4ef2-e8a0-08db8622a506
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2023 17:32:35.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x91rDGdvplNaKCY07AdpVMN/ml6iIbLkRv+uQlUG5Qt+1f+lmmP6ErTBikX426RjRLi2R51Dg5bwpA36mn+1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR05MB10325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 15-Jul-2023, at 4:28 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> !! External Email
>=20
> On Thu, 13 Jul 2023 17:03:14 +0530
> Ajay Kaher <akaher@vmware.com> wrote:
>=20
>> Events Tracing infrastructure contains lot of files, directories
>> (internally in terms of inodes, dentries). And ends up by consuming
>> memory in MBs. We can have multiple events of Events Tracing, which
>> further requires more memory.
>>=20
>> Instead of creating inodes/dentries, eventfs could keep meta-data and
>> skip the creation of inodes/dentries. As and when require, eventfs will
>> create the inodes/dentries only for required files/directories.
>> Also eventfs would delete the inodes/dentries once no more requires
>> but preserve the meta data.
>>=20
>> Tracing events took ~9MB, with this approach it took ~4.5MB
>> for ~10K files/dir.
>=20
> I think we are very close to getting this in for the next merge window. I
> ran several tests and so far it's holding up!
>=20
> I made a bunch of nits for this series, but nothing major. Mostly fixing =
up
> change logs and comments, as well as some naming conventions and
> reorganizing the series a little bit.
>=20
> Anyway, I'm hoping that v5 will be ready to go into linux-next.
>=20
> Thanks a lot Ajay for working on this!


Thanks Steve, hopefully I will fix all the pending nits in v5.
Here is the checkpatch.pl report:


./scripts/checkpatch.pl v4/*
--------------------------
v4/0000-cover-letter.patch
--------------------------
total: 0 errors, 0 warnings, 0 lines checked

v4/0000-cover-letter.patch has no obvious style problems and is ready for s=
ubmission.
------------------------------------------------------------------
v4/0001-tracing-Require-all-trace-events-to-have-a-TRACE_SYS.patch
------------------------------------------------------------------
total: 0 errors, 0 warnings, 22 lines checked

v4/0001-tracing-Require-all-trace-events-to-have-a-TRACE_SYS.patch has no o=
bvious style problems and is ready for submission.
--------------------------------------------------
v4/0002-tracefs-Rename-some-tracefs-function.patch
--------------------------------------------------
total: 0 errors, 0 warnings, 71 lines checked

v4/0002-tracefs-Rename-some-tracefs-function.patch has no obvious style pro=
blems and is ready for submission.
--------------------------------------------------------------
v4/0003-eventfs-Implement-eventfs-dir-creation-functions.patch
--------------------------------------------------------------
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#52:
new file mode 100644

WARNING: Symbolic permissions 'S_IRWXU | S_IRUGO | S_IXUGO' are not preferr=
ed. Consider using octal permissions '0755'.
#194: FILE: fs/tracefs/event_inode.c:138:
+	inode->i_mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;

WARNING: Symbolic permissions 'S_IRWXU | S_IRUGO | S_IXUGO' are not preferr=
ed. Consider using octal permissions '0755'.
#229: FILE: fs/tracefs/event_inode.c:173:
+		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,

WARNING: Symbolic permissions 'S_IRWXU | S_IRUGO | S_IXUGO' are not preferr=
ed. Consider using octal permissions '0755'.
#261: FILE: fs/tracefs/event_inode.c:205:
+		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,

total: 0 errors, 4 warnings, 297 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

v4/0003-eventfs-Implement-eventfs-dir-creation-functions.patch has style pr=
oblems, please review.
----------------------------------------------------------
v4/0004-eventfs-Implement-eventfs-file-add-functions.patch
----------------------------------------------------------
total: 0 errors, 0 warnings, 101 lines checked

v4/0004-eventfs-Implement-eventfs-file-add-functions.patch has no obvious s=
tyle problems and is ready for submission.
------------------------------------------------------------------
v4/0005-eventfs-Implement-eventfs-file-directory-remove-func.patch
------------------------------------------------------------------
total: 0 errors, 0 warnings, 129 lines checked

v4/0005-eventfs-Implement-eventfs-file-directory-remove-func.patch has no o=
bvious style problems and is ready for submission.
------------------------------------------------------------------
v4/0006-eventfs-Implement-functions-to-create-eventfs-files-.patch
------------------------------------------------------------------
total: 0 errors, 0 warnings, 182 lines checked

v4/0006-eventfs-Implement-functions-to-create-eventfs-files-.patch has no o=
bvious style problems and is ready for submission.
------------------------------------------------------------------
v4/0007-eventfs-Implement-eventfs-lookup-read-open-functions.patch
------------------------------------------------------------------
total: 0 errors, 0 warnings, 224 lines checked

v4/0007-eventfs-Implement-eventfs-lookup-read-open-functions.patch has no o=
bvious style problems and is ready for submission.
---------------------------------------------------
v4/0008-eventfs-Implement-tracefs_inode_cache.patch
---------------------------------------------------
total: 0 errors, 0 warnings, 68 lines checked

v4/0008-eventfs-Implement-tracefs_inode_cache.patch has no obvious style pr=
oblems and is ready for submission.
----------------------------------------------------
v4/0009-eventfs-Move-tracing-events-to-eventfs.patch
----------------------------------------------------
total: 0 errors, 0 warnings, 241 lines checked

v4/0009-eventfs-Move-tracing-events-to-eventfs.patch has no obvious style p=
roblems and is ready for submission.
-----------------------------------------------------
v4/0010-test-ftrace-Fix-kprobe-test-for-eventfs.patch
-----------------------------------------------------
total: 0 errors, 0 warnings, 32 lines checked

v4/0010-test-ftrace-Fix-kprobe-test-for-eventfs.patch has no obvious style =
problems and is ready for submission.

-Ajay


