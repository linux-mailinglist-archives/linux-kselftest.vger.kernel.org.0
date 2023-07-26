Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A01763EC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjGZSpk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 14:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGZSpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 14:45:39 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013002.outbound.protection.outlook.com [52.101.64.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98DE1710;
        Wed, 26 Jul 2023 11:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyZBOy8h4uhOFbdYADwMC/j5qMkHtEpgSOzv2IJ7JYVtmN21hT95/oUa0CjzP/iRiZ2EfpnsxBA+hpBMFvQLc8QQedAgYPpB5OqZQpBm61SIHSCydIu4WoidheMtZ8UsdS1BreMjHvmWgAdNtMzCAki6Rz9XJSI3uvZrurkT21foj2TODkjvuIyCAqXY1OQSRNowpOAf5eyCK4gyhNWCMFQ9xEkwfip3n+D6OEma4zwEWCHzc5MTOoaSQIzxrsczd1djcRhxI3zGpnsy5Y4K4LTNBErutQOTTrJXB+nvDjrxC5x+MNoU6bxHT1XxoFIpNUhTm6FvmvQnYH/q9qNAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z9N24JrafxDX1ux/tLxpu93EHW2WXX6K0FDP7HzjAs=;
 b=HwpiE/AML16tP9aMfcKpHuzGfEXb1CnbYK6qrfqlwPELPN61Xy4qlz46lpx4glC05G6yMRLxKXSgQMfeP6cPSpqFM8X0Gq/AOppwv+lw8qd+U2lS+BSRE9v5rs8rUEVxyHPA2El+Qrad6bRl7N+3Kt3hK0zaulwtIcUWe+LQTmhjrwZafioySqscuuQNHm1R1nDmNiduOVCqHt7TECQdEjb+xNYWKjWDOaERR9RpaAv1o7h3jm7GvHSJ4ehhm9bGW9l6IdAc+66ZEdbA6NS7fywkLqx6M68GYNO8rBlsyiCYfxGeT32aDXr/Cm9lJUDrcyfObFdGDQPIkWtIl+My8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z9N24JrafxDX1ux/tLxpu93EHW2WXX6K0FDP7HzjAs=;
 b=Vq5q2rajtzlZqVz4/jJfjpoCGjNmwTIGwJRf482P2ix8Aa5cpJ7w0RSaYcU3thNXbSj1OBgYOgFRHkH8WllPvco8bYJnwd5iq3R5NsRx7P82BwU5rKWpLftvsCfulg6t+TkIc5bku5chFGm5vaF9z/zdC5L7mfTkFrDkPB8LCeg=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BLAPR05MB7428.namprd05.prod.outlook.com (2603:10b6:208:295::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:45:35 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 18:45:34 +0000
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
Subject: Re: [PATCH v5 02/10] eventfs: Implement tracefs_inode_cache
Thread-Topic: [PATCH v5 02/10] eventfs: Implement tracefs_inode_cache
Thread-Index: AQHZvNQKHw/Q6Fj22kO7XI2K5rFska/LH5OAgAFJcQA=
Date:   Wed, 26 Jul 2023 18:45:34 +0000
Message-ID: <0FE7065F-6536-4311-AF41-4ABBD8E3ECF8@vmware.com>
References: <1690054625-31939-1-git-send-email-akaher@vmware.com>
 <1690054625-31939-3-git-send-email-akaher@vmware.com>
 <20230725190617.14c85997@rorschach.local.home>
In-Reply-To: <20230725190617.14c85997@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|BLAPR05MB7428:EE_
x-ms-office365-filtering-correlation-id: f5c1c82b-beb4-46f6-2c1a-08db8e087f39
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFqJK2ovuDiLSae8E6YdKaGDPypbsREm8WAIpNSVP807391GGwbwJw8lK/EkmH69qmVJ7R8xRPVity5ZWebHwUrrDEJbOrswB2GE38aRMOiw0ogUVmDlI/KP8NrwVLU0SlkNlBF7PjORa9gXyif499lyR4HMMRlh/3DR3cglEG4VHd+HhJws5AWZcpvdmS+qaZCOg4WVYe5VZWPAsaVWyu5UUm3nu1o+qAWwLf8VNtTIHOoJ4eczWTwuPnqswexo8Oz+Pnt76o7OG2qV20HutBCS0CexrFxoH8ViIvSY6UmFHF1j+XHy5qI7I5FAH1pnMn7NzR+ICj+TSZsxrHsPYwbtfZphwspCtO1n8EcCxuuISCBAMZB1nJgNAp9pzhk2O4khxV+hZ2Co7MRbLumzoBBWCV3IbyLcUqsOzdhe0w3yYxAqRuspe/Q3AFNnwxRpZuO8urmF6TOxmgGgGXimERT8RJXjVFQWr4xmc/NTPhqpq8px1TvsKhhXINxH+GH7mhs4lXuvocHu/YmmpPkmslwkQR2NuGPgoaNH11hYVJoWZx2cwlqDsGyjFxxhNoII0HPt5DOfGsUpEclJWeYdIcIIJZZ/pJ6+sprW/uVvg9+kUU+6N8UAZCEulY/Ba5vFzTsTVszak0S3K5/cQV+BbcvrPKz9HYqo5XTUuRJGEMG6FUfq7oSAc2fou/6NYYXS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(71200400001)(6486002)(478600001)(83380400001)(107886003)(26005)(6506007)(6512007)(6916009)(4326008)(122000001)(66446008)(54906003)(64756008)(91956017)(76116006)(66556008)(66946007)(66476007)(186003)(38100700002)(2616005)(5660300002)(7416002)(8676002)(8936002)(33656002)(41300700001)(316002)(2906002)(86362001)(38070700005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tzCl7LcGI2W1oTq/aE4j33F1oTcqL934eqvVC/Q2+gWexVG8YfAio7R2N00I?=
 =?us-ascii?Q?0TOLyuRnRltOc8VWrVxXEfjjj3Wg6wubYUCCncp22Oom9MlrxFHxTbkWX2vo?=
 =?us-ascii?Q?d+VREnlSCNVll7ABUBBr4AJvphPn+zSBP6ESgoJwEVG1AFexE6iB5yufXdCt?=
 =?us-ascii?Q?S/oOYfc+LlZfh4UsnwiyH/ISl4Y4AehkjO19/2uyeNnhzHxQqBnmjmZ0TZq/?=
 =?us-ascii?Q?nn45VvEoIQqTWF3OZE0X3QGnI4vgnB5wESlSEwNLoZPEctfuIogGmr+CUO83?=
 =?us-ascii?Q?T962XJ8qE62Pa9h7NZyTGGvEzkTvTofo3hZdEaYnQ7LOg6dbwV530c/nWj8K?=
 =?us-ascii?Q?bF3pEFWaTTrVEIpm+nvL5XIXcc/OBKY5M8MPiwyqxZ4AkNaug1Dnad9dak10?=
 =?us-ascii?Q?qZ6j4CLHxDz8veV4T+nkpJr238IwrKjAI/zKwaCL95PwwlZNVBnHV4sG162q?=
 =?us-ascii?Q?bQsGMMoSJ5ZJZmFCAV4Lu4Yx7CpPfAe7OcaYdpEUaK4B7ewm6ifswqOlhvVT?=
 =?us-ascii?Q?YTaKloSU0IRDRQD91ap9O3jwY5c+toT1u+LZ4f7d/zK8h/7uxOEpmNMYpcm2?=
 =?us-ascii?Q?REqYB0Mp1pSkhJcFOnK+D9vtoPmJ8Luzh/lwVlDPoizbkPirrl8dcbPDSWVY?=
 =?us-ascii?Q?GIKUkrXycVtxkP+scyvtHl1M/urS7mP0MMP8AuIeLxDCDGTNYZwbDH0ewf1b?=
 =?us-ascii?Q?f6JzrKoXaatSowxNjeKva/gqkv1nafmoPvBnVsiKITsfQxt6gVWy3M6SyyG/?=
 =?us-ascii?Q?2RJQt3ehwqW1eiqOuXwe1xxxDpHyCThfJdSwX3Hp6gmdc9zfa5CQGMVvXtBS?=
 =?us-ascii?Q?cGHM1/R9h/GuQ6yT6t0Aw6MFhwaUx26YjWrg6IIrXLhPXFuCrGwbm+745Dow?=
 =?us-ascii?Q?wUo6S3Ua97p4FkWjCdx57rppqer9HtjJHsWCBfo3Jvn1tOHvD8DW8i39aeK9?=
 =?us-ascii?Q?+lywnDk5ueAUow0w69ojnVUAx3+8ADnH3oaare6nqf8snrYdxjb2g9TYyK6T?=
 =?us-ascii?Q?6NTKuW9tNncvr2Eefq/fBmlhp6iCwo5XR2ghjr2ik2mYOyHhknRJ2ryuI/07?=
 =?us-ascii?Q?6tZfWQhmPU0q/98bcK83WKF2owQH3jAa3l9Y4KSV1ORwTjtkQL5sLm8ROG8Y?=
 =?us-ascii?Q?42K2Chp9R4VzKZw96/Lz1tgVm8xP1DDJMXMJqVoTV45Oz6QZ0CHmtGpQVWzo?=
 =?us-ascii?Q?ULkPpfTSywyyEr0+0fVdHmSz3qoruUWH/jTZjMEXaEtO3On/vuPfihK6B6w1?=
 =?us-ascii?Q?VMzxpRrdKN6O9Q/JjCkCTqPrKux5MEvGVaojPkIxucYtCKTOftwqIJIWgJzf?=
 =?us-ascii?Q?voDkMey0YQwGupQZpqB/xZiaWsTjrttTr5tk8FAAovVWCNB/DvjqPPYxvZ8L?=
 =?us-ascii?Q?xRLkFAxQmMnoE9dZZHcr8oUGjlLQ/YVY1dsgXoWUVbytoUQU3uchC4YOyYiR?=
 =?us-ascii?Q?g3pwXkoSOdU1O8LoUF7vUQXKp++SPIqW0W4j4NfAEoE0Xvp7vY+WLjpNYK/7?=
 =?us-ascii?Q?zB0fPywVYRz9OhvfwF5LGqlY0XsWnI8sposaxdT4HYhzrry3yh5DYMMhsXks?=
 =?us-ascii?Q?etMvwlgeZ8Si7fUzOubzauJrMBVyaKYki33bAOD1?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D439C1FB6769CE48B24CD7F9CE9BB7E1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c1c82b-beb4-46f6-2c1a-08db8e087f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 18:45:34.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wr+tm+0wYKcIoMrgyVbQuVDIAOInGA+JPemCltCmqIjSWN3m2PgRjSmPdW+2WoCpa7bMgy/sHP7//m4UCes7ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR05MB7428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


>> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
>> index 57ac8aa4a724..2508944cc4d8 100644
>> --- a/fs/tracefs/inode.c
>> +++ b/fs/tracefs/inode.c
>> @@ -21,13 +21,33 @@
>> #include <linux/parser.h>
>> #include <linux/magic.h>
>> #include <linux/slab.h>
>> +#include "internal.h"
>>=20
>> #define TRACEFS_DEFAULT_MODE 0700
>> +static struct kmem_cache *tracefs_inode_cachep __ro_after_init;
>>=20
>> static struct vfsmount *tracefs_mount;
>> static int tracefs_mount_count;
>> static bool tracefs_registered;
>>=20
>> +static struct inode *tracefs_alloc_inode(struct super_block *sb)
>> +{
>> +     struct tracefs_inode *ti;
>> +
>> +     ti =3D kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
>> +     if (!ti)
>> +             return NULL;
>> +
>> +     ti->flags =3D 0;
>> +
>> +     return &ti->vfs_inode;
>> +}
>> +
>> +static void tracefs_free_inode(struct inode *inode)
>> +{
>> +     kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
>> +}
>> +
>> static ssize_t default_read_file(struct file *file, char __user *buf,
>>                               size_t count, loff_t *ppos)
>> {
>> @@ -346,6 +366,9 @@ static int tracefs_show_options(struct seq_file *m, =
struct dentry *root)
>> }
>>=20
>> static const struct super_operations tracefs_super_operations =3D {
>> +     .alloc_inode    =3D tracefs_alloc_inode,
>> +     .free_inode     =3D tracefs_free_inode,
>> +     .drop_inode     =3D generic_delete_inode,
>>      .statfs         =3D simple_statfs,
>>      .remount_fs     =3D tracefs_remount,
>>      .show_options   =3D tracefs_show_options,
>> @@ -628,10 +651,26 @@ bool tracefs_initialized(void)
>>      return tracefs_registered;
>> }
>>=20
>> +static void init_once(void *foo)
>> +{
>> +     struct tracefs_inode *ti =3D (struct tracefs_inode *) foo;
>> +
>> +     inode_init_once(&ti->vfs_inode);
>> +}
>> +
>> static int __init tracefs_init(void)
>> {
>>      int retval;
>>=20
>> +     tracefs_inode_cachep =3D kmem_cache_create("tracefs_inode_cache",
>> +                                              sizeof(struct tracefs_ino=
de),
>> +                                              0, (SLAB_RECLAIM_ACCOUNT|
>> +                                                  SLAB_MEM_SPREAD|
>> +                                                  SLAB_ACCOUNT),
>> +                                              init_once);
>> +     if (!tracefs_inode_cachep)
>> +             return -ENOMEM;
>> +
>>      retval =3D sysfs_create_mount_point(kernel_kobj, "tracing");
>>      if (retval)
>>              return -EINVAL;
>> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
>> new file mode 100644
>> index 000000000000..49b5e8949e1c
>> --- /dev/null
>> +++ b/fs/tracefs/internal.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _TRACEFS_INTERNAL_H
>> +#define _TRACEFS_INTERNAL_H
>> +
>> +enum {
>> +     TRACEFS_EVENT_INODE     =3D BIT(1),
>> +};
>=20
> Let's not introduce the enum until it is used.


Ok, I will move this to v6 04/10.
Let me know once you will complete the review of v5.

-Ajay

