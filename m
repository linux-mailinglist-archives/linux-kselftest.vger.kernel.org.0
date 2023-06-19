Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4759A734B52
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 07:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjFSFYy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 01:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjFSFYx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 01:24:53 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011012.outbound.protection.outlook.com [40.93.199.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C004124;
        Sun, 18 Jun 2023 22:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3l2yIknf3iF5K4NvoRrthGAtsTW34Fwf4wr3YwKfS9pcJgBZ88CfLdqz5ahe7yq7gtm68d99tePYeZBR5H1MkFlQhFhzhG3iT3d8pDl68e+4iETRBceauejUlo2gjgda9wlnhEy9iXzXl8xVuyO98AyY609AH8QWLneGrdOYvFblc6gmbtICpwBA/sHDld6pGzJHp5BwMuCAxEeAUG5JHoenuOcq7gfCWbfLDTZI7qc8DmTO6s1DAcx79y7l6qETYYZrkwTPvlmVB8lQcaeveBjTpNOHfzkyGcCqz9McNnmCGh7wRB2pF1xA5yCHigOpvrMrA6vDb8YaOVA85c6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlocBnS4gMQxf7jQYBsvmJGAGie5BH7NXrF+ttG/vwQ=;
 b=Kdm3PbedCdUkDpHKg3TMxh85A4ufjCjE1+zXSEi1/BYlZTYZFlsePtQZuWNyWujT+hY7mM4cFkFrQTrynDIcpTaaMuZD4GF9kWx0snQtd8ieZ4L2Sd+Ay2UOH1wl/6sAoWN0hsmXgMwCnF6aDtSePPEzS96SZ7jTZTJYAxkyYzc8qRLwOfwL6Dzqgz7Wvxe2aa5z0XcIXaizeuthyfgX0amJ7o5hCSYLMqAWvDRJnvaraoRe51sEhumZtYQUNDK6qJ4LAgAanu/MZAyg4kCry7ljr9+Bql55A2XZM/uYwcMIKoEL4VfnfY1mg+IsE/qk4dXitHhUlOe/NGgzK+JwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlocBnS4gMQxf7jQYBsvmJGAGie5BH7NXrF+ttG/vwQ=;
 b=Oq+3UVyin9gS4pgY8vsp2F/skHqc9+/CfWOUIsZBk5UXbF27ccGrGRXFzz0zwZVUUlcl8jYWHWTcY2T1VsRdJu5av2ACN0krfzbw+GSDbUZu3KxP5yvWT5lootMhbdwCxFIOX8dWxHbctUBlf6ikjACFoW34eP7Kee5X9sQAV4M=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by DS0PR05MB10200.namprd05.prod.outlook.com (2603:10b6:8:15d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 05:24:48 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 05:24:48 +0000
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
        "srivatsab@vmware.com" <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v2 2/9] eventfs: adding eventfs dir add functions
Thread-Topic: [PATCH v2 2/9] eventfs: adding eventfs dir add functions
Thread-Index: AQHZfOihtJyVNC2DX0SIfIcIdDOcAq9QJhqAgANEQYCAPniBgA==
Date:   Mon, 19 Jun 2023 05:24:48 +0000
Message-ID: <5543FD40-36FC-4459-BF78-E2C0A361E9AE@vmware.com>
References: <1683026600-13485-1-git-send-email-akaher@vmware.com>
 <1683026600-13485-3-git-send-email-akaher@vmware.com>
 <ba8b6072-42b6-4275-83fd-5497654d77db@huawei.com>
 <A1697525-CE86-4CA3-A8D5-3452E9310A4C@vmware.com>
In-Reply-To: <A1697525-CE86-4CA3-A8D5-3452E9310A4C@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|DS0PR05MB10200:EE_
x-ms-office365-filtering-correlation-id: bd5f8db7-21f7-4355-d871-08db70858036
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /L3VvocBS0oh/8X4owJcRIEfyJbM1eFlaGpjP1toVk6LHJNHhIyWRZg1s8ATrXORpfavR5JkgYROoqjM4ZyaKvy+Iy1vjJBQ9fk9cHlqhAl8G9kNiJPwTmKgqWW5A31B3JyfA9lOpa28MxhbsivkaKAtTzzEeeTcksWqYtKr2rkBXL/CWELQcEu+FVc2O2OzaeTTLf1hBqmpAGbtuld4sV976WZUrVoKhtb0sZ0PLe00GRZqYmBR1yKXFaDPpuECN4ra3jpo13sPKA7QQJwb7G1rd8FFQol8t/HRv4ysvq3+weCKW602wx0c6r738hp8Lssmj6YE8JRvEE6g3zWLTEJYt9SosdgBjAZcaT/Go711zVIckYtfQ5LWNmTuMMWbjFH1T99nVN/o4OnBEJNESyTA9D31ZpFv6kmM1f2gOChHzfG5g/c3XcvMHxqu0XJ3sRl04gsGsMlD/8ZYq5rCHkEJAtIZs+Aru1hdvho0jSi87rYm+a7Y3zohabSE7cIdooX2I17e899tay7VaXGKfgC5ax4QUT4j/YfiqBOu92Kuw68YmfEJV9n516ITzILaoMktDWjwy1BK6Qf/yr+7Ph/dcAOIBLEdAVuDZkqy/fpZErCGHsZN2OeWPhjW2O5EAoqW+mq6HJB5TBg5YnQJ5t733n140Q54odPElO5WpZ/+CMzVGIZfN+Wdkrm0eEe5vVvqzFsaI4z+M8enmAhc0rrt/1PfcVqKec7ltiNflS8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(38100700002)(122000001)(38070700005)(33656002)(36756003)(86362001)(966005)(71200400001)(6486002)(53546011)(186003)(26005)(6512007)(6506007)(8936002)(8676002)(5660300002)(7416002)(2906002)(478600001)(54906003)(316002)(91956017)(66946007)(4326008)(76116006)(41300700001)(6916009)(66556008)(64756008)(66446008)(66476007)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ihKMew1L+2LdezHTtuHyyA57US8tmtiEWntmFcxJDKkr4K051kg1CO9dLOr2?=
 =?us-ascii?Q?3iKF5FvFB1wNpPKywpV1sw7u4bgRPVShB9r2Ej2X2w4fcSKw1+zxynDg3ko9?=
 =?us-ascii?Q?2SgEjukTbap6FBgoNqsiSu4B0rfJc/CCJdgxqb3BPMs2BnF54nBP2pyjqSvu?=
 =?us-ascii?Q?5L118x4DKiMMeQMZcDdf5K5IadFwWAEKryRvVfUvjGC8L/drL71Vw9vzViB0?=
 =?us-ascii?Q?R5T/CYxqIkm0Hxem7bVo3qGrtRwyupyZldj6GjXB9DmqSsft7XFT/FYsfFjw?=
 =?us-ascii?Q?At/nwT1jGI18MKux+E/oO2SNaC+3Mo4FurM3Oyphnn2FWLWLlTGf3tmWKRlm?=
 =?us-ascii?Q?D1MYwhD7nmYI21pM6Qic/AjhYCZ/mUyvyyei1r5n7ASda7ztpzCQ+BUeQ44q?=
 =?us-ascii?Q?lmXU5cyW1IR4PmOlRH7XlXvGRoqGOvCOebLK4/OdWb6lx7rk+SPjRa0/xrsz?=
 =?us-ascii?Q?O788m1R3bxJP8F93YQOCX10eiEAcxW108INYbadjUrkrWlseGWcGBmQAEFD9?=
 =?us-ascii?Q?bYY/NIEmCLFFm99C6y3x2U4IACQVouKvGEGTxXVR2tq//Vdu9FndsY0mODu1?=
 =?us-ascii?Q?y45iH0Bvq9HtQo9czrXPfsKmVmc4tstfDCVRbkthaxpNr4RV1uMZODHx7Xjd?=
 =?us-ascii?Q?862Gpep9hNd2TXQ22Y/k71Yjc0fHm/Y3M3M8+S4nOjyxaFBFvHqQLDiG7nMk?=
 =?us-ascii?Q?Qe2nB2fVWERcWCk6nGViWxSpCdGMkJiMMsJJI5SUXomUuaHABSwRWGb+12P5?=
 =?us-ascii?Q?ia1MT9rioA59Pr33tfyVorcQvXFYiDwmrDf6o+qXeUSgrYGcNn40XePA3cgg?=
 =?us-ascii?Q?FplkD8GK3AbjEFge6ZveFBORPlpWTQS/dMTMx3Sur0RoZTvPR5wL3fMwgFls?=
 =?us-ascii?Q?e8dh3EttHVtfB5sX0KceM2f3ZeT3g5SUt2ynfqg/KILo/kYGXBPHUdy5nJuj?=
 =?us-ascii?Q?w1kUM0tXtnYfizUP+IYPe06K/bsPbas+0Z0Lso/EQW35sL9V55hO//8YeqJm?=
 =?us-ascii?Q?9gaId8hZQ+SEOa86eil8fBUJcQhdiNDFWVcw4JsdDY2uKy8FtoSTU7QDx91N?=
 =?us-ascii?Q?2LoSnDctYStpN4naAQLJpRelvUSneHlLu9PzcKKrNZiwADeAwz5a919fs0hh?=
 =?us-ascii?Q?hHV4ugogmyDXKZ1Pg3TmUMhtT1KB045V8yNH0MciE17/VmUpgeXrYj9lEiVH?=
 =?us-ascii?Q?r4AXcuV5VbQs9W4hbUHGrIN6poKLs+oKHDRnSJo1ygbrZ2+glAyWNgPHB4c9?=
 =?us-ascii?Q?yYPQGLw+IEoQWpcek5DWOAYjI6WZW8ySkrFYhwoKL9bjr3y3AVsU1U2PHPyo?=
 =?us-ascii?Q?aK3166mlmoSsjRQyKnP5LgIfwqbOxRbkx0C/X5yUVwC+GbHTsBvmdZmpV/+P?=
 =?us-ascii?Q?d8ebGfMUrJ2oVCxBuC5JPtWMu3LG718gUReq7TKLUrksP/5FB+Xou1D9seeB?=
 =?us-ascii?Q?xB7FRv9VWsUylF3lPQMVROPrXpyAQaILTaz8/qF4wKdlriBx4EBGOy4amnD9?=
 =?us-ascii?Q?o3pWAryqTMuNGFRYooluAI/5bYnuMU1p++kCBcv1jHNNKxTuTw+AUBs2IHZJ?=
 =?us-ascii?Q?Ip/+sQb4itbh1nzrobAbuMfnXQiPy8D2Wv3rVyHh?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E1CC86D530D6B4FAB533A343D92950C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5f8db7-21f7-4355-d871-08db70858036
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 05:24:48.7017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dm4DGXtLnPH7uvpciHA3n3L0ea6rzCTEtWvl+ogXT6agwslyIiXPjwce2wU3nuMbsVGeJF1WzLX9xdZjfnfVXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB10200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 10-May-2023, at 4:55 PM, Ajay Kaher <akaher@vmware.com> wrote:
>>=20
>> Hi,
>> eventfs_add_subsystem_dir() and eventfs_add_dir() are almost the same,
>> how about extract a common help function to simplify them, like:
>>=20
>> +static struct eventfs_file *__eventfs_add_dir(const char *name,
>> +                                             struct dentry *d_parent,
>> +                                             struct eventfs_inode
>> *ei_parent,
>> +                                             struct rw_semaphore
>> *eventfs_rwsem)
>> +{
>> +       struct eventfs_file *ef;
>> +
>> +       ef =3D kzalloc(sizeof(*ef), GFP_KERNEL);
>> +       if (!ef)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       ef->ei =3D kzalloc(sizeof(*ef->ei), GFP_KERNEL);
>> +       if (!ef->ei) {
>> +               kfree(ef);
>> +               return ERR_PTR(-ENOMEM);
>> +       }
>> +
>> +       INIT_LIST_HEAD(&ef->ei->e_top_files);
>> +
>> +       ef->name =3D kstrdup(name, GFP_KERNEL);
>> +       if (!ef->name) {
>> +               kfree(ef->ei);
>> +               kfree(ef);
>> +               return ERR_PTR(-ENOMEM);
>> +       }
>> +
>> +       ef->mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
>> +       ef->iop =3D &eventfs_root_dir_inode_operations;
>> +       ef->fop =3D &eventfs_file_operations;
>> +       ef->dentry =3D NULL;
>> +       ef->created =3D false;
>> +       ef->d_parent =3D d_parent;
>> +       ef->data =3D eventfs_rwsem;
>> +
>> +       eventfs_down_write(eventfs_rwsem);
>> +       list_add_tail(&ef->list, &ei_parent->e_top_files);
>> +       eventfs_up_write(eventfs_rwsem);
>> +       return ef;
>> +}
>> +
>> +struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
>> +                                              struct dentry *parent,
>> +                                              struct rw_semaphore
>> *eventfs_rwsem)
>> +{
>> +       struct tracefs_inode *ti_parent;
>> +       struct eventfs_inode *ei_parent;
>> +
>> +       if (!parent)
>> +               return ERR_PTR(-EINVAL);
>> +       ti_parent =3D get_tracefs(parent->d_inode);
>> +       ei_parent =3D ti_parent->private;
>> +       return __eventfs_add_dir(name, parent, ei_parent, eventfs_rwsem)=
;
>> +}
>> +
>> +struct eventfs_file *eventfs_add_dir(const char *name,
>> +                                    struct eventfs_file *ef_parent,
>> +                                    struct rw_semaphore *eventfs_rwsem)
>> +{
>> +       if (!ef_parent)
>> +               return ERR_PTR(-EINVAL);
>> +       return __eventfs_add_dir(name, NULL, ef_parent->ei, eventfs_rwse=
m);
>> +}
>=20
> Sounds good. Thanks for sharing code snippet. I will consider in v3.
>=20

Hi Zheng, I have moved common code to eventfs_prepare_ef() in v3 3/10, 4/10=
:
https://lore.kernel.org/all/1685610013-33478-1-git-send-email-akaher@vmware=
.com/

-Ajay

