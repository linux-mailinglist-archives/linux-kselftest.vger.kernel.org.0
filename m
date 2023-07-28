Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAF76743E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbjG1SJS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjG1SJP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:09:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B49719AF;
        Fri, 28 Jul 2023 11:09:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4Y79031066;
        Fri, 28 Jul 2023 18:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wWAZ15RptXgnhXznea3QLWD1Cqb4fg9WL0XHm/8Dg0Q=;
 b=PLVUJvKNkFBprIObSlVJkUoLJfSkLFsKY24noxvMt2XWji160Xdk09rDMuK/2SigpeN1
 KsnwMVLwB5bjzhXbkgrw1k4roYcxVoOV+HPhnJX57vYpFGs9SNA7abWEtZPKPwcApBRB
 rljv5xtkgv3JLZqCDTU1JPoO/oA7s/QqXgMp49y2x9qS0cQbBvO1kLslhUvYCTRM2kvI
 2BT8m/2wiLwcy6n9W5Dgpvy5wR8dzwzFPB2BMI7BHg/8x7FoM7y+UjWgOYQX7uVL6KCy
 mPv7ShBAJ3Yc+Gnc4sG+Q/3kM5Zt1jg0KlL4xbB/yfOnM6A7DFbxu4hbs0RjQPLdBIjI lA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05he4d8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 18:08:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SHpqCn026224;
        Fri, 28 Jul 2023 18:08:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9vmq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 18:08:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGVt/k9q6F0PQGH/z/cIxlsU6i8lb6Y6Qvu/aHA62iIactC5VmSSs9wglMH3GMbJ+S4ZNcaOOz0K28J6YGCDaHZ7ZfbQ1NXAnbhyXWqwS0NZaECms1bX8MkBEBG4jGmZexZnC0zB8eIkWPp/9f+fSzMbXUEjDY4IH8Ef3wZiuW701ISEG3iLzt1OKkkSX6AiTQoXbRfU/FJU4j63M6ANN2D7nZaY4RROCoELwd4TXwFu4LUZ4hnfA6BLBpwIYMC0NFc8qn3kBcQc3i7Ikad8IvbM+GsLuV24CawMSvUerrce2Y2iqBseCJ4I1gn0ccOkhGC4otpjllnLvr/OqG4QWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWAZ15RptXgnhXznea3QLWD1Cqb4fg9WL0XHm/8Dg0Q=;
 b=KKVGhGIlCLrUO//1EU6dDhmZ2HWygvXN5BUw6lC7sKAH3ok9avv7pwsOt6fZ9oPhB+bfko/jgROptHOwf/BlJublid6DD+EIl4ar8nZmYJ//DbDjSkQ1MifGr7+0wbESLyiTYJy33CmvtKOg+BVUPsF9E3P7TMsM3B5uWWugbVLiFhDVVBpd34WQ7DYzc4Kr5odoC3ApM6uZ3sXwu6XwOkk/LSpMa51W87rBF/PLNyz1+ITpx6Yo7cBFstBrWndJCqPvfdGz1o2tJGwPuQfP7HNLbQwaakfIwfG8oQSFslRa5UJVpLoMtSjBke242/1H3j1fLD3ro1wldSwrtbQpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWAZ15RptXgnhXznea3QLWD1Cqb4fg9WL0XHm/8Dg0Q=;
 b=oNHoNW3cJofoWaSBhDX4Rc+JBUL1y2N/g8DgO4h5OsFB9m44R9Sx1l/nzYGSImTTi344245L0poy1x2PMatdT6u04g+jLu6UIkRsbiAmlOai0IthTH8KQCsAmHhqjcFDAZplozIOgMMI/LZVrDuIqsH4B0Wm6DAszTNz95KN5n0=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by CY5PR10MB6024.namprd10.prod.outlook.com (2603:10b6:930:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:08:52 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::69d6:8729:ee7c:cc45%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:08:52 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Netdev <netdev@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Thread-Topic: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Thread-Index: AQHZvvi/xI4ekXqIdU+9CLD2lWipK6/KsaiAgAMxnwCAAHfvgIAAD1EAgAASBoCAAOubgIAADV6AgAAJqQA=
Date:   Fri, 28 Jul 2023 18:08:52 +0000
Message-ID: <264B7DFC-D343-476E-ADA9-86FAF708FE87@oracle.com>
References: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
 <E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
 <BB43F17E-EC00-4E72-BB3D-F4E6FA65F954@oracle.com>
 <799d6088-e28f-f386-6a00-2291304171a2@linuxfoundation.org>
 <DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
 <20230727194311.6a51f285@kernel.org>
 <5844361F-E776-4C52-BA8F-7E13D6B4EDE1@oracle.com>
 <b247219c-f988-bcc2-36f5-22659e2ced96@linuxfoundation.org>
In-Reply-To: <b247219c-f988-bcc2-36f5-22659e2ced96@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|CY5PR10MB6024:EE_
x-ms-office365-filtering-correlation-id: c65a769a-0a1a-498d-77de-08db8f95b392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQNT2Uzfmp1ruVok7gcakiADGO0O2dzcdpHXi5X/6qYvB6BhlgHM2TCjuCewVhE4fZYvzlRojGZDv9VK4x5vShiNwkWcmVUK7E6n0vC3kNjsxu6v0ATKif+etXr7Pv3Li7DbuBARsKu8EC8dc6l7T5f9xH9HIkHsquKI7XoXWU5pnwX15CNuUGEh48Jc9g9y3Iy3zHNQzRVC1LEJa82VSXd9VNVA2ougV6yZt9jxih0xq2oTiswOZicW42wD5xweAtltVooVAPWbjEWI1Fn6hJ+tOy/NCRavM48xUfyYAlDEAEB1S9aNCtzUGo7Zm6Igd8B9nVddqK6ANywO/7OwJ/nRxohdCpvmr9AS6ndiJnsmrbRdoQRFJMvL9/cbywWd4uOApNB2TzoltOAoAQzz9his+WAdz0KyFTBbbe9rsUrTxRX6dI/FPFHAMAIvLs+kZpD5e218CzT1rkSEsS98AjdAMj/6DEYO2oZRQ94FULF8n3KRVl576bD/f/bJY3XHw+2WLkVfoO48pOcTLM29L+2UAIPwe+6yMBLcRVjJMkyW6In3BBCBYe9LCmmU2fR4iDT1yD3cE1VhjLmjNpW+8aAjaApZsBD7e3gVLbVFc5nlZbhF4wpgT+gq+EncQ7fuiT590WP3OaI2cYtXSl/YGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(2616005)(38070700005)(83380400001)(66946007)(122000001)(66476007)(86362001)(38100700002)(41300700001)(5660300002)(36756003)(66556008)(66446008)(107886003)(4326008)(6916009)(7416002)(316002)(64756008)(8936002)(8676002)(6512007)(6486002)(6506007)(186003)(76116006)(71200400001)(53546011)(54906003)(33656002)(478600001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mjov9fQtE1XiRh6H8pngN4CZ86DdcVU9yaOsx6ZSDFupF4S4KT1d16GOCuSX?=
 =?us-ascii?Q?SmTMVRZU+j9i9JmE9rGu2ZJf1JhwGb4lYTBOaIvZqVPNde7l88GJTxJoa5S3?=
 =?us-ascii?Q?fxQGq3/Age9bcwmsXwcp9EwbiHQtSh8uZca4sxMeouf9/p2dHICS7Rk2aX5Q?=
 =?us-ascii?Q?d+ZBByW7axxmCc9W1mv9hsECBYclHtnSpgooNdhc4D2exjEyiH+7XIwpkgnR?=
 =?us-ascii?Q?ZSLgDKFuXko81e/GVGIBZSYDdMi3IuIdFnKmk1gaWmxkV7OvKTnX2RXvfA3m?=
 =?us-ascii?Q?qJdIoRei3izPyXCUytORDiimcLwPCVrxhg9B2JrXUo1ESgU3BAX6FkeLcLx5?=
 =?us-ascii?Q?XK5NpukUMGBpvZiknCsMByTrrpoJ5OleFX7Fmr6wKWz3F3PQJ6KIboqLkjfh?=
 =?us-ascii?Q?Pi3EeEML+jAG/jUL5db17+W//tl5CdugmEstq4HOQMfd5zl/cNh+isQRyqNd?=
 =?us-ascii?Q?pzF7CvJ15suENpKlVhR4h2/UpxDWRO/JqNrn/SCpxVoLEget4cuWQqjdjlCE?=
 =?us-ascii?Q?hDxefcS0vcoYw2BIY8wfxxZ+oxATVImRZ7bULdNXNrhcEFLLrDcZ7FPlAcDL?=
 =?us-ascii?Q?Gq8yeXHrONHLTTro/VBk+976pkqfTkNxo1V+UIiO16ZThrzbYccGe2eAxfLF?=
 =?us-ascii?Q?n45jHnb/YNzjj1Kxpuwwa03tp+62toCWYsKE8X9Bg0LIIK3utZikgi6Crh46?=
 =?us-ascii?Q?57sXpmbuJ+LwvDlSDWqHb5gifzdkz3xQE+FMVvXCkmXC3KVNpfrSvtJCwtpc?=
 =?us-ascii?Q?x4R1o3uJW3o0WSuitOMT1Em4hqrP110NrSAY4jYEuIzOB1vNYOZDEwUfunkP?=
 =?us-ascii?Q?UTEM4VdGF866MrEs/ZiQ3o/L5t6caUfqF53PVy1rmpmMolHEdJt8pF0mTnwl?=
 =?us-ascii?Q?wEwbieYX0yD4V6f/iF932t26pbAIqpVXoNDxBqdRRIXcf2hAbES5Lat3MWPy?=
 =?us-ascii?Q?z4iGNJ8Y7h4vlF32Yr2DduD4wvxZbDFRANopmhWock9d//n1nWal9gtpZvzZ?=
 =?us-ascii?Q?YFx/l46WDEDJawlIYW2lZol6Y73ukRBJSIV1jmtXP2iSw8WDmXbXTmdieaUb?=
 =?us-ascii?Q?9W/2IFAfowWCdkb8r0HmUzvl+NpsyAop6hDtO6vSUWNiu9HEJjnaVGWCVnrC?=
 =?us-ascii?Q?ySmzQYhcoZ4PB2wr9HXXVI/cdPLLtwfnWlltQpc6Dp8aIsxLRiBmd3H0XKEO?=
 =?us-ascii?Q?CCVueGIEeN/MdEqYh3++EbliNfxuYwm9d13X+jGu+DwClrj0tuMUxAmJXhPQ?=
 =?us-ascii?Q?v2o3n7hV3qhe548W7uhia4IEVPSD88fWnTF0sz3aKMR3Ao2ReN1hcdZysTIJ?=
 =?us-ascii?Q?jN5FbTMzR8pPJh1/5qEcr9Oro1fQ51jKZsQp5W6G3IH04EUTuLiPIgoDPeNZ?=
 =?us-ascii?Q?XRh4o149pjbyvCv0tFWFtd2e6tBNHx63amh0x+OT9MeEWSfs2OSqPb0IdMjK?=
 =?us-ascii?Q?ErCXiHoQqiQ6dO2tBLZuAJox5h8mCwtMgRKGh3IKqsKjh7moLaJQTmtxDU1B?=
 =?us-ascii?Q?arbo96+295eKHr4PfsMAKe6sW1u+lCK9GFdWJ190HbXUc9W3elBkPeU+VbSV?=
 =?us-ascii?Q?he0Gexn9kiUT3GEvP0G4BKOFnykJwm8hj/O3AJLMWfoBSX7qm+l97nhMxwrI?=
 =?us-ascii?Q?LDa+/awE7b1XHYesBahAjMPsehjGpyVNsh7qhMHAefkiD+ePLILM+CSmvxvP?=
 =?us-ascii?Q?a4KplMmVJh24qAadzGw5HWArb1Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E1C98D3787BE942B014288C9A22B2AA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K5pFwRpGq9tZD9QryTzg9P1HeZ3XZcSydGOmNFRS2lMg9DVpXTNZxwxn2bxV?=
 =?us-ascii?Q?xDM6G5wjwBkeMKtnCGuJdWGJFcJo7NqqcWukHXApXEiXIgJjll9ArAZezdGY?=
 =?us-ascii?Q?mj5yRR4w8J+8YXxtLgVDO+6ogrL7lDYJI2hu47mPBuu+mS/cn3Mp49Ht6lVn?=
 =?us-ascii?Q?I4za10LZJ22658ewL3BUxjnsDCkB7lfOKTddzoseofIxSTyBnfGQQ0TYTUbT?=
 =?us-ascii?Q?/eR3CIfeS/KN5VcPYXfMCyQCJYKM1Xb3qa6+Mh4xpVByeoqnzOfKwjF5lTX9?=
 =?us-ascii?Q?2XdmYh9zR/xZdKcBKt3VgtU2COz/CCHuox9gkwl4JN5XcoGO/mNZGgjjLQ44?=
 =?us-ascii?Q?qlHNJ4IqnWFovDTHFmHc9V0HDjxt4zS8iQQbYKgO75BomILmCfr3f5PytVlO?=
 =?us-ascii?Q?2YkMatnD0IZYOMjidn14xesROb+TLaidcSeVKsJaZEXvmrtWlc5EpbwECS9t?=
 =?us-ascii?Q?tLEgOv/tt3js104zCk28UQ0J11rMzFPpmG+8CmiSLXRzbSZKi/QSmlGKKz7E?=
 =?us-ascii?Q?cEVz1eotqxjkfMcBvLq01MfvKqGAb+kd+3bCj3IBQufazMxPw8qXXBj0pQII?=
 =?us-ascii?Q?E6iGE62RnwYC0vYvZFRdjGPOcT0VBr9cyovAtKu9P8HRR0Xg4caLh+rLa4Gl?=
 =?us-ascii?Q?xcNcc9Qu79HFz9pV0tYcMnfD4FrYR6AyQ9T6s/c60hYHmgcAX3zaYF4kbOaw?=
 =?us-ascii?Q?KNpf5vmOyKKNlb8Ce88CkfTepm9u6c0vtaH7n2dd35Wf/pNOnL2RQFJpGx6U?=
 =?us-ascii?Q?CpuoPjqCAY2DpPFjqMqSAFZrP7Tk/JszLxHeli446v6Fln/71EL3VLNhwKqi?=
 =?us-ascii?Q?r4PhDpNP92T6v274unXylVDyjOnlKIdrjN0FQfy/NW3fBbA2Fah+v3W6By2b?=
 =?us-ascii?Q?0UPXRQGBOfhsVR4BhSZwJEPOFmvJhAmILkSjdWrrUi/74gk0EajWNEt/L035?=
 =?us-ascii?Q?bQCj5v6atlhb3XqpWWnl7A+SLle3TMcPo60/msvTy8Fo3DlqD1LLiNwMkpcl?=
 =?us-ascii?Q?pVL2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65a769a-0a1a-498d-77de-08db8f95b392
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 18:08:52.8438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5Vn6+gDIzNmyxRHgVYQjgtJeBqOZzPk7q+Pv1UYtnGod98de9E/Up/kiKoJkqSMK9tw+d+Z4roP/qgb7yWBasixrREODskHrN5zmIk4LFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280165
X-Proofpoint-ORIG-GUID: 9TGbA2reeEmlN4RKlS1CV9neEUquCcd6
X-Proofpoint-GUID: 9TGbA2reeEmlN4RKlS1CV9neEUquCcd6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Jul 28, 2023, at 10:34 AM, Shuah Khan <skhan@linuxfoundation.org> wrot=
e:
>=20
> On 7/28/23 10:46, Anjali Kulkarni wrote:
>>> On Jul 27, 2023, at 7:43 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>>>=20
>>> On Fri, 28 Jul 2023 01:38:40 +0000 Anjali Kulkarni wrote:
>>>> Jakub,
>>>> Do I need to revert the -f runtime filter option back to compile time
>>>> and commit with that disabled so the selftest compiles on a kernel on
>>>> which the new options are not defined?
>>>=20
>>> I'm not 100% sure myself on what's the expectations for building
>>> selftests against uAPI headers is..
>>>=20
>>> I _think_ that you're supposed to add an -I$something to
>>> the CFLAGS in your Makefile. KHDR_INCLUDES maybe? So that the uAPI
>>> headers from the build get used (rendered by make headers).
>>>=20
>>> Take a look at Documentation/dev-tools/kselftest.rst, I hope
>>> the answer is somewhere there.
>> Ok thanks, I will look into your suggestions.
>> Anjali
>=20
> I sent a 3 patch series with the fix to this problem and a couple of
> others I found during testing.
>=20

I was just about to send the fix, but thanks.

Anjali

> thanks,
> -- Shuah

