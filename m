Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D2B6FDCB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 13:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbjEJL0R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 May 2023 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbjEJL0Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 May 2023 07:26:16 -0400
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837645FE9;
        Wed, 10 May 2023 04:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARF3Mbcntv5tnbE7c+ReplgAvEHZhiQ+JdoSSzvkri6F613i/jYW+XrbiJrbq4NcHBQWTu8KKAqZ3OcvN9tPmXheZXUJTF9LBsbtava8+BrdvOjE2qbcaVtsyMNYdEB2dSMsQLjgceXL0DTDDaoD0syChYeqMqg9J7x+/sYE4iru1IwwYHnC1e/sQfR6f/BdIDWHJwqOGbkThBoTqeA0HcLnm2nFyR7fNuA59nNVu+PCgpkN0e2pxEO9pLC7lj/KoySeld1OxV3GjVQanGots+MGuwm3Vd6+lqgnZhgm2royxcr8KsoomR77dLVsnACKH4p+K6AVAuwS1T0M1+hbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E3l3hIF5rJ7n1l+9newh6hypc/PYr0Re7XTgC9La+Y=;
 b=feYGbkGxAUNtkaXnAOtUezUSE7kEw9/9io1m5H5saMBveq6F2vEDKPoukGJzxDYdgkj94/a574xGTiCP1D9U5lcCa+RmvZPOyEIpFND3+x2n9BkQsYtTM/lbVqDaFuk26kKw00p6Wo8kiu1fSogGQ3l47KRDjfcRH5Ww0L7qrLlBCn/GWtGnf8v5g8HG6WXwN1DLFnrcMGZ9bX4u94N04PPUJQayvSoGveKU6pkmH3KDfVvv4NaIKk4HNj2vkcWW/bKRw3szvFYP8hAWjo7VLZ+QFqkmM0k0ldU4BJMKpDoN3JTfs7pB5OeyqSm21eNjGFM93bXjBpjEWXCqL54Sew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E3l3hIF5rJ7n1l+9newh6hypc/PYr0Re7XTgC9La+Y=;
 b=aW+qAi7R1htu98yeskfhht7+6ogA2RX+83yvzyTST9gMbZC4IVQcs4Vi4TekYBK78bAbdDcDX04A7zF1BQhym7NBu90/PjdyLSJ7xPbaYfZ1/bVE1u+uXNLAYpg/yU+niRa63F00cKob6DJ+n1G/8hYRPWp+U6Z8tqRfhuEd6/c=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by DM6PR05MB6987.namprd05.prod.outlook.com (2603:10b6:5:1da::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 11:25:26 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 11:25:26 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Zheng Yejian <zhengyejian1@huawei.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "chinglinyu@google.com" <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v2 2/9] eventfs: adding eventfs dir add functions
Thread-Topic: [PATCH v2 2/9] eventfs: adding eventfs dir add functions
Thread-Index: AQHZfOihtJyVNC2DX0SIfIcIdDOcAq9QJhqAgANEQYA=
Date:   Wed, 10 May 2023 11:25:26 +0000
Message-ID: <A1697525-CE86-4CA3-A8D5-3452E9310A4C@vmware.com>
References: <1683026600-13485-1-git-send-email-akaher@vmware.com>
 <1683026600-13485-3-git-send-email-akaher@vmware.com>
 <ba8b6072-42b6-4275-83fd-5497654d77db@huawei.com>
In-Reply-To: <ba8b6072-42b6-4275-83fd-5497654d77db@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|DM6PR05MB6987:EE_
x-ms-office365-filtering-correlation-id: e80920c3-9de7-4e5b-4444-08db514940f5
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHBy4LQ6P3b9nSD5NvwNXKD+BBySbwg5s5GFbX2DICyURHK7eKKsBaXKGqrG+4INE5sHuL+CbzP1wlmdvKFGfogcI1vcgFIDGQsY23wiRIx7vraK5R0dEkAFdYu/s1DPTIFgro0yj6MJ5t15/JmEJxqYHx61ZEDtGm/G3+ITSJQETgBQBQQMCgH0htoNnRafOc9x17ZbEn4K290cjGyaVgtIq0Dlp+A6ZH1diA4EdeNhQ2Mr4cGPtoh4O1KHD4y1C5IBr1E6pRbHOfv315vQWNEmDEsgMbMvqDzFwmk4FTqtPWxw65p6QoXRsneCazXkD/vF3cDbGTpWHh9Kco5mPrapIMMOWPuA55644xKWPlgbJNxXXTpWPkEJsW/BB3kF87JYI3vHgs3oKfgHzkQU6XdRCGTG9PKrGVvG5hJOxzq+ncbPC+Im+Ru4Lfexm1dI6OCK2okRAQlQuqhQItsSCNs59LM6h/YENZN5fE/rCRL0mfkHpD3axZ8wwEWIRNrVAyPnIUAKkKFPNLnlsHb/lEmBW+apZr08872L5JUyIWPYr1ceT9j9SIS0bBtWE8vI/G5LI+YmwBGYVSf0e6D4E27I1BYXJpSFAUQXvlL0l+O2Juf7EerO+JrYuxi9g40hu3nZA0PQK4HOLBz8mjHjPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(86362001)(66446008)(36756003)(33656002)(6916009)(64756008)(91956017)(316002)(54906003)(76116006)(66556008)(478600001)(66476007)(66946007)(4326008)(6486002)(5660300002)(8676002)(7416002)(8936002)(41300700001)(2906002)(30864003)(71200400001)(186003)(38070700005)(122000001)(38100700002)(26005)(6512007)(6506007)(83380400001)(53546011)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5xO3D1hjZ6ielP7pSf3GDUomr9JHh99Nkc6Pr5bsf07+8YgUbvLGBf35ombp?=
 =?us-ascii?Q?3DEN20tov1ZADQZCD3uTzp66bS0XIlPAUJgrgZZQMrSmgznGYHaywCcxBIsj?=
 =?us-ascii?Q?39DyGqbDC8WL3oe7Irma4ftSl6Vp2/0rWkI84v+qmT7dLHtrUw4wDZYUMtK9?=
 =?us-ascii?Q?4AAojqxFqLBeCyIvYHQJwz31V1kzy4X13HJmEJzDh3bV64OwyZSNW6Rzy96a?=
 =?us-ascii?Q?X2h/nfoC0UzMRdwiVdgtewK2kbNlTIdRGpj6iSPPFQdIYTOU3A0a8gg7IA4y?=
 =?us-ascii?Q?ZdqPbhRuwo9kvnjCZZ5hLLXZPNtLqV1Q0HUTSuZoFNB41sZPcac/dQ6Zng66?=
 =?us-ascii?Q?14GYf9c5uCBI4sx4uJ2uB8hcfU1icO0hXJwdKtlF/UyKCt+p1NBswlZR28JA?=
 =?us-ascii?Q?oAYInvMTAEitEdZ2xw5hSxKi+wvhocN3Ll9dtEPqM7LeJhErHAwXexAG4sVi?=
 =?us-ascii?Q?hBNUfvkhtE2X91Ke14yv995iWnPQZYcOa1D+oPFMffw69WCPcKwl6z6+5t/Q?=
 =?us-ascii?Q?RDfsYIqa2Sptkzb0BjhhxgZa10ywauQ7kN8H+N1Mwl6Dkgv398jn/d9CmBqg?=
 =?us-ascii?Q?JkxQk9LpfJwqXN4jeurUcl8yeHWj+BDvAOz65qbK3hu/TL9uk7jEO0scdJap?=
 =?us-ascii?Q?mq4PjfkTew9Dr376AyXKo3t+eRGDcKyqm3oDA0IK9qXLgbnZEoLXNrHniIrn?=
 =?us-ascii?Q?lFgzMaNCPjeBykT4L4bHKzmKjQmuc14edVk1annRNhIjBPTTV2ukP7bTykNz?=
 =?us-ascii?Q?gWhzbF5B0tTonMhqso8f0AN0h4RSPooHvlbhZMEH6GiAgnAUOZCa8RPxOBSp?=
 =?us-ascii?Q?ST7BjTA4h65KynajGZ7PCPc9yAEXNvOje+Pxn9R4ORIYiEULlhueivHmgTTo?=
 =?us-ascii?Q?PO0I23DNR2GLUtzNF9KVl6dXAGsZmwShkVVTnLFhDBIfZha9IrEAm1umobTd?=
 =?us-ascii?Q?zFb3ByNxbWfMIWCVR4dzDW+Cj6/3ukzcHaT5V07ks76aibQpRkFeQTuCZXEJ?=
 =?us-ascii?Q?DZILVEj2nGk38HFJnAOs5m/6nOPOtq911czVFKdRH2W/HIYE4kx8DI+H+RiI?=
 =?us-ascii?Q?MLlExzV4+FGMCTZwMreFCc+NoyCOCDzDORI+2y2wOgID+mRFy73RX0ZgghaP?=
 =?us-ascii?Q?P++RBv5cF3PL8RdJbxl1sZZ19M5HBl1wVsgV5v7ypTO9GZyi58StHLeqAfnH?=
 =?us-ascii?Q?MO/jwNaL9FIc/40wCZydL7PIHJMVXIo+8DP1eGaoU22tKJRjLeeihTBH55ZJ?=
 =?us-ascii?Q?lgdaLQnDXJz/B1PaeKbd1G57/LPHeJDnVvwoVlOmwCIWEubPelWfxpPdG5E1?=
 =?us-ascii?Q?x37a9+y8FBrW2JAUHF0tdOP6dTixobck32yZHhRofJ14Xj5gdyT2irg/u93X?=
 =?us-ascii?Q?lqSiC4PQLWlFMLg/Et8LhQZX4CsWI4mDR3/VGXSaV99Ho9/sEzwfymS73ndY?=
 =?us-ascii?Q?x4Gd59d71yIslkpz4o4pdgLipIHs6GE+DjKh9DfeqN6zw6pDToQHw9p01stq?=
 =?us-ascii?Q?gy7AW4eOAm3f0OvNnJsPfZVqx0MC25OFY7LRNDI76n8nHP7cxdIsrE+dsLF5?=
 =?us-ascii?Q?QS1y8VV90md8yDy3If+dx55igf3KPKTLRxnTXVfA?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BDE9D3E32A046440B9F9DE2715C915C1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80920c3-9de7-4e5b-4444-08db514940f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 11:25:26.6950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrJcxabdahfqcthoK7CGMz5VLIxL1srw4NYIW6mBJmVJGuWWZVeAR66Z0+nvsBo1auoL2GUATjOTbOMEiM3DRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 08-May-2023, at 3:02 PM, Zheng Yejian <zhengyejian1@huawei.com> wrote:
>=20
> On 2023/5/2 19:23, Ajay Kaher wrote:
>> Adding eventfs_file structure which will hold properties of file or dir.
>>=20
>> Adding following functions to add dir in eventfs:
>>=20
>> eventfs_create_events_dir() will directly create events dir with-in
>> tracing folder.
>>=20
>> eventfs_add_subsystem_dir() will adds the info of subsystem_dir to
>> eventfs and dynamically create subsystem_dir as and when requires.
>>=20
>> eventfs_add_dir() will add the info of dir (which is with-in
>> subsystem_dir) to eventfs and dynamically create these dir as
>> and when requires.
>>=20
>> Signed-off-by: Ajay Kaher <akaher@vmware.com>
>> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> Tested-by: Ching-lin Yu <chinglinyu@google.com>
>> ---
>>  fs/tracefs/Makefile      |   1 +
>>  fs/tracefs/event_inode.c | 252 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/tracefs.h  |  29 +++++
>>  kernel/trace/trace.h     |   1 +
>>  4 files changed, 283 insertions(+)
>>  create mode 100644 fs/tracefs/event_inode.c
>>=20
>> diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
>> index 7c35a282b..73c56da8e 100644
>> --- a/fs/tracefs/Makefile
>> +++ b/fs/tracefs/Makefile
>> @@ -1,5 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  tracefs-objs        :=3D inode.o
>> +tracefs-objs +=3D event_inode.o
>>=20
>>  obj-$(CONFIG_TRACING)       +=3D tracefs.o
>>=20
>> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
>> new file mode 100644
>> index 000000000..82caba7e9
>> --- /dev/null
>> +++ b/fs/tracefs/event_inode.c
>> @@ -0,0 +1,252 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + *  event_inode.c - part of tracefs, a pseudo file system for activatin=
g tracing
>> + *
>> + *  Copyright (C) 2020-22 VMware Inc, author: Steven Rostedt (VMware) <=
rostedt@goodmis.org>
>> + *  Copyright (C) 2020-22 VMware Inc, author: Ajay Kaher <akaher@vmware=
.com>
>> + *
>> + *  eventfs is used to show trace events with one set of dentries
>> + *
>> + *  eventfs stores meta-data of files/dirs and skip to create object of
>> + *  inodes/dentries. As and when requires, eventfs will create the
>> + *  inodes/dentries for only required files/directories. Also eventfs
>> + *  would delete the inodes/dentries once no more requires but preserve
>> + *  the meta data.
>> + */
>> +#include <linux/fsnotify.h>
>> +#include <linux/fs.h>
>> +#include <linux/namei.h>
>> +#include <linux/security.h>
>> +#include <linux/tracefs.h>
>> +#include <linux/kref.h>
>> +#include <linux/delay.h>
>> +#include "internal.h"
>> +
>> +/**
>> + * eventfs_dentry_to_rwsem - Return corresponding eventfs_rwsem
>> + * @dentry: a pointer to dentry
>> + *
>> + * helper function to return crossponding eventfs_rwsem for given dentr=
y
>> + */
>> +static struct rw_semaphore *eventfs_dentry_to_rwsem(struct dentry *dent=
ry)
>> +{
>> +     if (S_ISDIR(dentry->d_inode->i_mode))
>> +             return (struct rw_semaphore *)dentry->d_inode->i_private;
>> +     else
>> +             return (struct rw_semaphore *)dentry->d_parent->d_inode->i=
_private;
>> +}
>> +
>> +/**
>> + * eventfs_down_read - acquire read lock function
>> + * @eventfs_rwsem: a pointer to rw_semaphore
>> + *
>> + * helper function to perform read lock, skip locking if caller task al=
ready
>> + * own the lock. read lock requires for lookup(), release() and these a=
lso
>> + * called with-in open(), remove() which already hold the read/write lo=
ck.
>> + */
>> +static void eventfs_down_read(struct rw_semaphore *eventfs_rwsem)
>> +{
>> +     down_read_nested(eventfs_rwsem, SINGLE_DEPTH_NESTING);
>> +}
>> +
>> +/**
>> + * eventfs_up_read - release read lock function
>> + * @eventfs_rwsem: a pointer to rw_semaphore
>> + *
>> + * helper function to release eventfs_rwsem lock if locked
>> + */
>> +static void eventfs_up_read(struct rw_semaphore *eventfs_rwsem)
>> +{
>> +     up_read(eventfs_rwsem);
>> +}
>> +
>> +/**
>> + * eventfs_down_write - acquire write lock function
>> + * @eventfs_rwsem: a pointer to rw_semaphore
>> + *
>> + * helper function to perform write lock on eventfs_rwsem
>> + */
>> +static void eventfs_down_write(struct rw_semaphore *eventfs_rwsem)
>> +{
>> +     while (!down_write_trylock(eventfs_rwsem))
>> +             msleep(10);
>> +}
>> +
>> +/**
>> + * eventfs_up_write - release write lock function
>> + * @eventfs_rwsem: a pointer to rw_semaphore
>> + *
>> + * helper function to perform write lock on eventfs_rwsem
>> + */
>> +static void eventfs_up_write(struct rw_semaphore *eventfs_rwsem)
>> +{
>> +     up_write(eventfs_rwsem);
>> +}
>> +
>> +static const struct file_operations eventfs_file_operations =3D {
>> +};
>> +
>> +static const struct inode_operations eventfs_root_dir_inode_operations =
=3D {
>> +};
>> +
>> +/**
>> + * eventfs_create_events_dir - create the trace event structure
>> + * @name: a pointer to a string containing the name of the directory to
>> + *        create.
>> + * @parent: a pointer to the parent dentry for this file.  This should =
be a
>> + *          directory dentry if set.  If this parameter is NULL, then t=
he
>> + *          directory will be created in the root of the tracefs filesy=
stem.
>> + * @eventfs_rwsem: a pointer to rw_semaphore
>> + *
>> + * This function creates the top of the trace event directory.
>> + */
>> +struct dentry *eventfs_create_events_dir(const char *name,
>> +                                      struct dentry *parent,
>> +                                      struct rw_semaphore *eventfs_rwse=
m)
>> +{
>> +     struct dentry *dentry =3D tracefs_start_creating(name, parent);
>> +     struct eventfs_inode *ei;
>> +     struct tracefs_inode *ti;
>> +     struct inode *inode;
>> +
>> +     if (IS_ERR(dentry))
>> +             return dentry;
>> +
>> +     ei =3D kzalloc(sizeof(*ei), GFP_KERNEL);
>> +     if (!ei)
>> +             return ERR_PTR(-ENOMEM);
>> +     inode =3D tracefs_get_inode(dentry->d_sb);
>> +     if (unlikely(!inode)) {
>> +             kfree(ei);
>> +             tracefs_failed_creating(dentry);
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +
>> +     init_rwsem(eventfs_rwsem);
>> +     INIT_LIST_HEAD(&ei->e_top_files);
>> +
>> +     ti =3D get_tracefs(inode);
>> +     ti->flags |=3D TRACEFS_EVENT_INODE;
>> +     ti->private =3D ei;
>> +
>> +     inode->i_mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
>> +     inode->i_op =3D &eventfs_root_dir_inode_operations;
>> +     inode->i_fop =3D &eventfs_file_operations;
>> +     inode->i_private =3D eventfs_rwsem;
>> +
>> +     /* directory inodes start off with i_nlink =3D=3D 2 (for "." entry=
) */
>> +     inc_nlink(inode);
>> +     d_instantiate(dentry, inode);
>> +     inc_nlink(dentry->d_parent->d_inode);
>> +     fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
>> +     return tracefs_end_creating(dentry);
>> +}
>> +
>> +/**
>> + * eventfs_add_subsystem_dir - add eventfs subsystem_dir to list to cre=
ate later
>> + * @name: a pointer to a string containing the name of the file to crea=
te.
>> + * @parent: a pointer to the parent dentry for this dir.
>> + * @eventfs_rwsem: a pointer to rw_semaphore
>> + *
>> + * This function adds eventfs subsystem dir to list.
>> + * And all these dirs are created on the fly when they are looked up,
>> + * and the dentry and inodes will be removed when they are done.
>> + */
>> +struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
>> +                                            struct dentry *parent,
>> +                                            struct rw_semaphore *eventf=
s_rwsem)
>> +{
>> +     struct tracefs_inode *ti_parent;
>> +     struct eventfs_inode *ei_parent;
>> +     struct eventfs_file *ef;
>> +
>> +     if (!parent)
>> +             return ERR_PTR(-EINVAL);
>> +
>> +     ti_parent =3D get_tracefs(parent->d_inode);
>> +     ei_parent =3D ti_parent->private;
>> +
>> +     ef =3D kzalloc(sizeof(*ef), GFP_KERNEL);
>> +     if (!ef)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     ef->ei =3D kzalloc(sizeof(*ef->ei), GFP_KERNEL);
>> +     if (!ef->ei) {
>> +             kfree(ef);
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +
>> +     INIT_LIST_HEAD(&ef->ei->e_top_files);
>> +
>> +     ef->name =3D kstrdup(name, GFP_KERNEL);
>> +     if (!ef->name) {
>> +             kfree(ef->ei);
>> +             kfree(ef);
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +
>> +     ef->mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
>> +     ef->iop =3D &eventfs_root_dir_inode_operations;
>> +     ef->fop =3D  &eventfs_file_operations;
>> +     ef->dentry =3D NULL;
>> +     ef->created =3D false;
>> +     ef->d_parent =3D parent;
>> +     ef->data =3D eventfs_rwsem;
>> +
>> +     eventfs_down_write(eventfs_rwsem);
>> +     list_add_tail(&ef->list, &ei_parent->e_top_files);
>> +     eventfs_up_write(eventfs_rwsem);
>> +     return ef;
>> +}
>> +
>> +/**
>> + * eventfs_add_dir - add eventfs dir to list to create later
>> + * @name: a pointer to a string containing the name of the file to crea=
te.
>> + * @ef_parent: a pointer to the parent eventfs_file for this dir.
>> + * @eventfs_rwsem: a pointer to rw_semaphore
>> + *
>> + * This function adds eventfs dir to list.
>> + * And all these dirs are created on the fly when they are looked up,
>> + * and the dentry and inodes will be removed when they are done.
>> + */
>> +struct eventfs_file *eventfs_add_dir(const char *name,
>> +                                  struct eventfs_file *ef_parent,
>> +                                  struct rw_semaphore *eventfs_rwsem)
>> +{
>> +     struct eventfs_file *ef;
>> +
>> +     if (!ef_parent)
>> +             return ERR_PTR(-EINVAL);
>> +
>> +     ef =3D kzalloc(sizeof(*ef), GFP_KERNEL);
>> +     if (!ef)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     ef->ei =3D kzalloc(sizeof(*ef->ei), GFP_KERNEL);
>> +     if (!ef->ei) {
>> +             kfree(ef);
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +
>> +     INIT_LIST_HEAD(&ef->ei->e_top_files);
>> +
>> +     ef->name =3D kstrdup(name, GFP_KERNEL);
>> +     if (!ef->name) {
>> +             kfree(ef->ei);
>> +             kfree(ef);
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +
>> +     ef->mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
>> +     ef->iop =3D &eventfs_root_dir_inode_operations;
>> +     ef->fop =3D  &eventfs_file_operations;
>> +     ef->created =3D false;
>> +     ef->dentry =3D NULL;
>> +     ef->d_parent =3D NULL;
>> +     ef->data =3D eventfs_rwsem;
>> +
>> +     eventfs_down_write(eventfs_rwsem);
>> +     list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
>> +     eventfs_up_write(eventfs_rwsem);
>> +     return ef;
>> +}
>=20
> Hi,
> eventfs_add_subsystem_dir() and eventfs_add_dir() are almost the same,
> how about extract a common help function to simplify them, like:
>=20
> +static struct eventfs_file *__eventfs_add_dir(const char *name,
> +                                             struct dentry *d_parent,
> +                                             struct eventfs_inode
> *ei_parent,
> +                                             struct rw_semaphore
> *eventfs_rwsem)
> +{
> +       struct eventfs_file *ef;
> +
> +       ef =3D kzalloc(sizeof(*ef), GFP_KERNEL);
> +       if (!ef)
> +               return ERR_PTR(-ENOMEM);
> +
> +       ef->ei =3D kzalloc(sizeof(*ef->ei), GFP_KERNEL);
> +       if (!ef->ei) {
> +               kfree(ef);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       INIT_LIST_HEAD(&ef->ei->e_top_files);
> +
> +       ef->name =3D kstrdup(name, GFP_KERNEL);
> +       if (!ef->name) {
> +               kfree(ef->ei);
> +               kfree(ef);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       ef->mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> +       ef->iop =3D &eventfs_root_dir_inode_operations;
> +       ef->fop =3D &eventfs_file_operations;
> +       ef->dentry =3D NULL;
> +       ef->created =3D false;
> +       ef->d_parent =3D d_parent;
> +       ef->data =3D eventfs_rwsem;
> +
> +       eventfs_down_write(eventfs_rwsem);
> +       list_add_tail(&ef->list, &ei_parent->e_top_files);
> +       eventfs_up_write(eventfs_rwsem);
> +       return ef;
> +}
> +
> +struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
> +                                              struct dentry *parent,
> +                                              struct rw_semaphore
> *eventfs_rwsem)
> +{
> +       struct tracefs_inode *ti_parent;
> +       struct eventfs_inode *ei_parent;
> +
> +       if (!parent)
> +               return ERR_PTR(-EINVAL);
> +       ti_parent =3D get_tracefs(parent->d_inode);
> +       ei_parent =3D ti_parent->private;
> +       return __eventfs_add_dir(name, parent, ei_parent, eventfs_rwsem);
> +}
> +
> +struct eventfs_file *eventfs_add_dir(const char *name,
> +                                    struct eventfs_file *ef_parent,
> +                                    struct rw_semaphore *eventfs_rwsem)
> +{
> +       if (!ef_parent)
> +               return ERR_PTR(-EINVAL);
> +       return __eventfs_add_dir(name, NULL, ef_parent->ei, eventfs_rwsem=
);
> +}

Sounds good. Thanks for sharing code snippet. I will consider in v3.

- Ajay

>> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
>> index 999124459..aeca6761f 100644
>> --- a/include/linux/tracefs.h
>> +++ b/include/linux/tracefs.h
>> @@ -21,6 +21,35 @@ struct file_operations;
>>=20
>>  #ifdef CONFIG_TRACING
>>=20
>> +struct eventfs_inode {
>> +     struct list_head                e_top_files;
>> +};
>> +
>> +struct eventfs_file {
>> +     const char                      *name;
>> +     struct dentry                   *d_parent;
>> +     struct dentry                   *dentry;
>> +     struct list_head                list;
>> +     struct eventfs_inode            *ei;
>> +     const struct file_operations    *fop;
>> +     const struct inode_operations   *iop;
>> +     void                            *data;
>> +     umode_t                         mode;
>> +     bool                            created;
>> +};
>> +
>> +struct dentry *eventfs_create_events_dir(const char *name,
>> +                                      struct dentry *parent,
>> +                                      struct rw_semaphore *eventfs_rwse=
m);
>> +
>> +struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
>> +                                            struct dentry *parent,
>> +                                            struct rw_semaphore *eventf=
s_rwsem);
>> +
>> +struct eventfs_file *eventfs_add_dir(const char *name,
>> +                                  struct eventfs_file *ef_parent,
>> +                                  struct rw_semaphore *eventfs_rwsem);
>> +
>>  struct dentry *tracefs_create_file(const char *name, umode_t mode,
>>                                 struct dentry *parent, void *data,
>>                                 const struct file_operations *fops);
>> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
>> index 616e1aa1c..3726725c8 100644
>> --- a/kernel/trace/trace.h
>> +++ b/kernel/trace/trace.h
>> @@ -359,6 +359,7 @@ struct trace_array {
>>      struct dentry           *options;
>>      struct dentry           *percpu_dir;
>>      struct dentry           *event_dir;
>> +     struct rw_semaphore     eventfs_rwsem;
>>      struct trace_options    *topts;
>>      struct list_head        systems;
>>      struct list_head        events;


