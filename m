Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EB47D5AD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 20:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbjJXSoB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 14:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbjJXSnw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 14:43:52 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 11:43:50 PDT
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C2186
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Oct 2023 11:43:50 -0700 (PDT)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OFWhBD019020;
        Tue, 24 Oct 2023 18:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=Oxf3+2zCprDj9RWY2Nk4eEnUO68zjt07gLx9waYxwC4=;
 b=mkF2LDpB4HHicCAhZke9PR3/xk9wHNrK2z6XrTK2j7sqYaKa7hIVJZ1NJGNR/9Yy5S57
 nmQv/FiA1ZhYXlMIJaRTMLx4OXNIg1v38q7F1FkzSNV9eEM8bwuYeHwGJk8DXaAs95f1
 7VO09JbnGRtlrhj1hl5X9sqVr++bX4SMLZqzYM1ior8bCUGX8L6rWJNmmd5HdOiYp+0q
 QGY3N/C6mNPVf1Wx+zUcI2fuG6Fe8YUti6OMA4UX2f8MBpxEwteSoHUoWQQoTOkj25JA
 2q3D19hziXM1n5+K1962W+0nbErYxn8J28yXjYDaQMNLNES6EBx9XMMfjLBo5f48daaL LA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3tv59yud1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 18:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etNSpS15d6EdohOG/R5E2Bfq/dFfyMkJ8LhBiFAzqywPAuPOcMgS7N7LGn310hnnMBu9Jl9QR5SSQ1n8PODYBaRc2+FQ4RWRm35ZhEjkc8/jLKN0SSvyrIi5abZO/pMSh/q7mpfJIBkFNp3JOyHIy0i5sIMIj6REYMpOSrOky4MGQF2MJKuRL9cfvEnES7FShPJeUV2LDewgqfYDLfmi2Z8mRjXsEyCmdjtGC0oIsFBeuVV5S/dJItjy+6eFy+ZPWMIGcFuN6a+qhu3jbgr/3uINGyu4X4+tsu0nqZS0Pvvb9Wd82tkdZ1XjcxkyVhwQXW2IdCcJLbimlzn9Q6U9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxf3+2zCprDj9RWY2Nk4eEnUO68zjt07gLx9waYxwC4=;
 b=og8RJoL0IVlPlYkSrSLSW/bRk2nPb6YNfhULrxdIzEqyigAAn8ikZxSFemL7JDL4SH7MYIVkDERrUYGn5nQVDTS0YETXHnoRdyANszsZuUuiitYkoJhskZ2Jc/p2UC9kwPqb6KT1/hAcLL2yVJCGsPxMitUQY9GLQ0PAJwbEEw+wQX1jSWBjMk44EM/rNlqfnfgXhfoG0m7maAjoOfS+r9aZLZ0vhp3RHq2BdJBVyTyF1uWAa8ctPpIGMU/xY/eMPbkDAM1UZtP1JWMwnZLseFfD3IC9ov7Silfut6NuFBVc5YGW715zuUm/pmQ2/w5xvtJJAf2E0tLhTGW1BPl7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by DM6PR13MB3969.namprd13.prod.outlook.com (2603:10b6:5:2ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 18:34:20 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::7c1d:8738:a9f7:d505]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::7c1d:8738:a9f7:d505%6]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 18:34:20 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Marcos Paulo de Souza <mpdesouza@suse.de>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "mbenes@suse.cz" <mbenes@suse.cz>
Subject: RE: Purpose of gen_tar
Thread-Topic: Purpose of gen_tar
Thread-Index: AQHaBqbwiYsmMVueWUCeT0MVtcSkmbBZQqMA
Date:   Tue, 24 Oct 2023 18:34:20 +0000
Message-ID: <BYAPR13MB2503D83D75CC553E3D994AABFDDFA@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <2nv6zlkrhaeosjjtpvsfl5gehrlmujocdbmaxyqgpkxzmjnuuz@cj3bajg37xb7>
In-Reply-To: <2nv6zlkrhaeosjjtpvsfl5gehrlmujocdbmaxyqgpkxzmjnuuz@cj3bajg37xb7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|DM6PR13MB3969:EE_
x-ms-office365-filtering-correlation-id: 33b12225-4c18-4570-d4d8-08dbd4bfd686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X7QBy8WYy6IRtztEIMyzl/eLJukhLk+DxAjRQGLCpdR7uA/KnBPuXdEyHl0I9VFkOzjPcnOtcOHu46ww9NjccKJfGlruqkvbX6aRY77mYheOoCtCZFabvM4v7D9kgSzD0p3EG0LLAlJIoxFjumijRHWu5ouPbZfy39nUL5+FtbbuAeG0LdlAGm2Gkykfn/EQYRB3xf0JmmfFlrEFW0099Q9Ir2ORXM4oBEoKTfeaPK4nJhUXwdkKCE9xKP5c69jtUHCRS2x1m0A+MG6HQdlhVObzxM8RpqrJHfibJGPA3p5s5kOW8lw5/iYKMfyC3s8Xhdmx0ZSHVcD+tLSns75m9bskIAqgWegcs/s6spUFwygGqPw9xDb+OR8l2UGyuw9W4sCbWePJw88IzfHGVfCPKNCJtthyo4fffr2QH3Ja2ae3zS8/0m7pLhmZ9RZ7tZMbsE9IRp/cWGln2AoNk1n4s3Ex8iypyIenB4Kfi8QSEHOfxdOIUfeuFvXGdZxdJaNgEm+1B6viGsk/V28mQ/XmytTVCV5KE2/wWs01X7c1eV8sBEkxzaVGbJKpbQEdQzx11upWB6F1olJg2cG3K/Ut6kmDDxtUMWhJIhleYzJTe647042Ss3YtN+C7/N664TQuSp/FZL1KYeyfyR7fsFLaT8YKgf2pX6yWbJjd6wmOdGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38070700009)(9686003)(7696005)(6506007)(55016003)(38100700002)(122000001)(82960400001)(86362001)(33656002)(26005)(71200400001)(41300700001)(2906002)(478600001)(83380400001)(5660300002)(8676002)(8936002)(52536014)(316002)(4326008)(110136005)(66946007)(76116006)(66476007)(7116003)(66556008)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wP47KoY5lxzjB13SYol9zaxAB8irvEwPMosUlvw1M8x2FD8cC7dS/iYxVtkI?=
 =?us-ascii?Q?1giAGZglhZSjnuxFOBGKTHGPGk2jWhEE8xqhWF0ylGkV/0bD8XycLLyjtIW9?=
 =?us-ascii?Q?HKVHvdYuer8nYiTx9xyyLr8VBHYr6vrCjQ7tpy7G+X8yEiQagsNrM8jytSA7?=
 =?us-ascii?Q?FR9LX0Q3VwAFQV8szeQT8Krn7d1J6WZ/Cip/d/P8QlPQEZcdoEVaKOblgAL5?=
 =?us-ascii?Q?RmdRHnX7wUEHnoywS3mP2FKegpqBTcOMCX4WqBfwCMNyL5v/OqxlRhkGdz6v?=
 =?us-ascii?Q?wdD/ezPT86Vh6ShyI9/pd4IcNyt66mEEpGgXZlN1/qgcQWu5zQyE3CU5UtfC?=
 =?us-ascii?Q?6y8w65gl1keBnINAdU/IUMRghdVgrUH1LdYHuYp/uN/sQKQ1vCuOiAxfITdn?=
 =?us-ascii?Q?eDSRo8voa/SBP9X7cPFkbGlC2UmLVErDU6BdksTeZF7jkNx7MdJoBSpy//7g?=
 =?us-ascii?Q?zPmqSE3eJvkhLQhsGVCHuEzbsaZmVjptMdsP8B926dc3vr6Tlol4HqYZs+tV?=
 =?us-ascii?Q?lFWjg1AvKO4rTxV5McoYfeElkfk39oT9mQWc/tJF56ljAnMPYxVCy85E8t2B?=
 =?us-ascii?Q?OX1P6EORClHephaEd64c02E8WHnqhgAZxi9G7GqOeUy6inrm/WaSEvPDOXvw?=
 =?us-ascii?Q?SHIkAIVLAsIqtrOWP5vaDaEeg+NCW2PCvbNV77zLhBNAFsEHwdJRhJ6NOCjZ?=
 =?us-ascii?Q?OeWtPfPpfK+ApJXSogT4Zu36Gr3r1zckk0DHtbUpxD9j56S1hZpc+q8ncMw8?=
 =?us-ascii?Q?rvHQcQHYJf1cDaiQKu0Hv/+F+2D7GniQmaIWWAsUOn523DM5KNluVgg9sTd2?=
 =?us-ascii?Q?havYrl1DXsDbjXkSBPMY3iAy6DMbOC7F2D4MVZ1we6YpObaXFvzmNK0stJRu?=
 =?us-ascii?Q?y1+25zytF1wbrAvQA4KBSBJo7txW24FFzFqaoJ2qGY5Ki8/+O+0+Ffj5C2fk?=
 =?us-ascii?Q?/f8mL7f4AtoTHuXICu1GIJetKj+rNhRofcjZL1ppVt0GlSlBSUw7XxT1AuM1?=
 =?us-ascii?Q?Q7GwghGoW5YtNIdBWv1XENX36snEoBtKqFutIopgJcCPMezvVKkPP1lvVjpS?=
 =?us-ascii?Q?Sg7kLoOlncxrBe41tTw9MRmLwgWfYYHXdXX1ahh4X/hG5qUsRpwy8JTGfq9r?=
 =?us-ascii?Q?S8xWav1VhQ9SceexbsEWrI96eUt1JsiwU7H0sPSwCJDF1IbFjw7yTwq47wJy?=
 =?us-ascii?Q?6/7ebi77MavLxfeGSDgRCJjjPMXqTMSUgHqNVkavmQ7vQ3udjm0tG6R2QTzs?=
 =?us-ascii?Q?m7CdpS/4D85wuHjJIq291WPsx6KrvFC5osarrjexWTI18T/zPJU+DgBmhphg?=
 =?us-ascii?Q?bpmUvqBJopWsyUMXEjOMYAQdvkc0d8mQI1AHIt0ZRwodgBj6de+BXfjFTM+W?=
 =?us-ascii?Q?8fsPizy5WNWq+W7whnp2lP56qqzgnCUzVe0z3Oe3sP7LoQ885ytbh+quZkog?=
 =?us-ascii?Q?px2dW5vjrYoBJttP5I/MV8cR0s5+EjGSDiNaX6ohHkB49G8lcTBZVASodemn?=
 =?us-ascii?Q?Btrt26rh6qV85S+ULFnV8I+vcCTnYikyO463vwv+/ldqNCSGMetnuoiE2lle?=
 =?us-ascii?Q?rJ8W4QBd14XMljl70Dc=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CmoD5WMCzHdMmSnBkgrKmCPEAA60BDgxb6j7m2C+wqX/cGYtJLWNJbexz9qA5GTrzjx8bEGfZZ7eob1IjZA7oKPz+e1a3TPzGcBPU8Nr4ZgUcps1bPukTJDPpKH4/opdDueoZlanhPeObQKQAkmqVoxsPgr8Wd2hhMFNA6VEPIzJ5qBffMGnacOcaSkW2xsLZFjAVSctDc1BtYylq115OWoul11EtTqdQ2nYn9Z7uar1GWPmnBH/fauUZtNsSMJoPjGdmD3xmOT51GVoA598vWX8dShkcXuEVlUJiNiH6CjccfgCNykdzl6xGRmzSg2vANGOzRtUnoEljyYv4zkCKLsRkHBHEkN++g4l4DEONOMoGIj/eUMoayow5eqaZufyRrEytemzpVPcYvKhVzF8xWKkwOLk3UIVRWHvndYxVgPp0NZ/C7/+JXBhtMhmcZ89ifwErg4hXD4peqExci7OShQ+JsOUb11FWbmSO0hSU7ZuZr9BKItKk6x6gJGuCj2pDzZYKie4ZvoPL2yOueyXXbtTYjpg+CIHfF51hYfrIjJ5PZRlWchsm26vWc2Lo8wySM4KeABwE8MDkI/Cn7/X/7+eULVS03BLaJFnVtpJwlVXbMGf9VQZCv41Wx2Hmb5RFOUPIqz6gMUFiJa7W9aPACYObNDkYQnCcDs7+qMWCBMtpbeb5Ur2SGXpjg7GGgvaGyU37OTpVQIrKg+fZrGgH9IQWPTHAQxyPwMENUwGnklLGBGVdl29SRpvXLkFYZxLCO72+GCP262lsijsjyvfxMI/UABamSsosEazsc9ijrjcFe8xT39BvlC7mr+7kMh/qHYNIdFwVaidUyOX1h+ZKA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b12225-4c18-4570-d4d8-08dbd4bfd686
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 18:34:20.5830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImCwieVUlupYCm9i/9/8fPHDy+d6L80Jobi5XaHx+JWPBP5K8IZeFsS1wpF8onF1NNJxG4Sv87eecPA9Yu5Kcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3969
X-Proofpoint-GUID: e9O1zi32-Higf4uoysyTbA1Q6ODMCmzi
X-Proofpoint-ORIG-GUID: e9O1zi32-Higf4uoysyTbA1Q6ODMCmzi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: e9O1zi32-Higf4uoysyTbA1Q6ODMCmzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_18,2023-10-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Marcos Paulo de Souza <mpdesouza@suse.de>
>=20
...
> Per the kselftests documentation[1], the gen_tar target is used to packag=
e the
> tests to run "on different systems". But what if the different system has
> different libraries/library versions? Wouldn't it be a problem?
>=20
...
>=20
> While the current approach can work when the selftests rely solely on she=
ll scripts(cpufreq, kexec),
> those who compile userspace binaries (cgroup, alsa, sched, ...) may not w=
ork.
>=20
> Am I missing something? Is gen_tar only meant to copy the tests to be run=
 on
> systems with the same libraries or with the libraries with the exactly th=
e same
> version?

gen_tar was originally intended (I believe) for developers doing cross-comp=
ilation.
The SDK used for cross-compilation of the executables should handle issues =
such as
library versions (and of course, CPU architecture and endian-ness).

I've never done cross-compilation for the same architecture, so I don't kno=
w how that
would work, but I presume there is some way to compile code for another sys=
tem
with the same architecture but different libraries.
 -- Tim

