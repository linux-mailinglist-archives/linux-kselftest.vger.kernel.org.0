Return-Path: <linux-kselftest+bounces-12167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF25D90DB2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 19:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95877284F69
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECCB14D28A;
	Tue, 18 Jun 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="bC2Gymjj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B751494DA;
	Tue, 18 Jun 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733563; cv=fail; b=X0FdgvC+WF2iLIVSxQ1S7I8eczLj05wJr70xxqnt/KKYM8XcJyoMWmdJLrQo5HMTu1sVjOc4X5P0Uyv3WryRkxhfnuTETeczbNO/QnXIUj/tANuxcmhmPXzJgdjldrzCb5aFJNfBcpoF3RsPzoHh3SGibVbYZkPlenQ/cDacjeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733563; c=relaxed/simple;
	bh=XXLWZfxWqE3aOPscROhr1+DTcz9UJj5YAKBJ8PJkcTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XWeACXIlyv12BZ9t52wtWj0/GDErje1WqZDYED6VkcKpL4J2IJYZO+vPgjPmypip0HsLIFmzygM283WaQyMPF9M54+RgOzY/eHWGzOY6320l7HPTSnDC8rPDotdSwy2tyTZImUvafMg7HyHqOucM4PuwpJDN810mJDJ+W/K/SaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=bC2Gymjj; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IEvFF8013377;
	Tue, 18 Jun 2024 17:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=YuZmX78
	6LfAR5tM+oadhmf56LZMk/9bDtSm91cP9lUs=; b=bC2GymjjZ+qn3sPKfuGOmfM
	jEmg0tLK2KNs3fsOVQ+5T+UTxpfIjWyCypvaBQSKPrwDMbMO0WV2G1r0K7wGZ/1E
	XMZ9ISJVJvNvr9PyVTbbOAAgdnYWCiUvZ+p/EVYw/vZQ44SLNVeARzNRFfHVQ4ru
	MCL5i3E/xc9pS2Lqv1781kv4x1Sib19p/rcS1gg/O8vsNlAq2Ik1tVaarY97Tqgi
	kzzUoAcjIZtlC6uvygs2h/J1PxycnZrqpeYjQiCGFAb6F2KQpSUXGNkaY5tOruXz
	2kf75sUWloibCnUDVLIbZLdAG2cmReNw4Xc93K6ldwwyZjYeZnp2b0o26bk6jEA=
	=
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ys043uaue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 17:29:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY5/jxEDxlLayCIfMen4EemTF5ghUV+nlJvZyYdivESGIJpXm7sejityut1JCFxsR0nScZuSCgtO3BZWUDGGMhjZonlodGKGMqKY4HTV/jgZsKiYgfWQZdVuyRMM+tn9sKNJm2Ld7WX/6ZcFStc9tNgYq4RCBFHr0PELyNTqZca0Mn1UQtprtQC7Xusaso1RaS2nIEEKxLOUqDTw94h9KK5kY/T3L8kd9RaOKOICZBkNvT6XMEbn83D1+oQTrOgVMWcAniBlXgyuT+kG6WfN+lrgre7mXvjhxR3QI4ZNhrT2Csgyeujp9lm/hIbsljk9XWrdXFK00DMaB3dZxeYOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuZmX786LfAR5tM+oadhmf56LZMk/9bDtSm91cP9lUs=;
 b=YpHBeQanJKHoi4a3O6iOoPBlGC0wElda1U22ujPVLQMU/QQgvdRhifhRqMikMI1mdrfCdC5OVSR0ddqFGrkLjHtnH5fkpMxGgevgevbhwJBixusDbQw5YfxFmud0e/HjBOFDWfoQ/TQNqoDC4phkv5C5/vBRhV7N3SzoRGRMdnSEeRpWPrsetq8OrKBDfKqKtO2aSP//371lGWg9xOh/sVLgIAsi4gjlzlLS059khVCk5WcrTKit1epnjb/zE5iGEsnSWQfj1OhISB7XYynOB1eoTay7znr/ZQ+WlVcx8e+L6gpBx1eYjtNdfpGK5ijl94gotn6DTGyU5xhkzk1MHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by DM6PR13MB3739.namprd13.prod.outlook.com (2603:10b6:5:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 17:29:01 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:29:01 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Laura Nao <laura.nao@collabora.com>,
        "kernelci@lists.linux.dev"
	<kernelci@lists.linux.dev>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Testing Quality Call notes - 2024-06-13
Thread-Topic: Testing Quality Call notes - 2024-06-13
Thread-Index: AQHawYyiSszksCNA4U+sAhFVJLG6sbHNxEuA
Date: Tue, 18 Jun 2024 17:29:01 +0000
Message-ID: 
 <SA3PR13MB637241E8BDBDDD625D4F5129FDCE2@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240618141529.60741-1-laura.nao@collabora.com>
In-Reply-To: <20240618141529.60741-1-laura.nao@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|DM6PR13MB3739:EE_
x-ms-office365-filtering-correlation-id: b3edfe18-20d0-4158-1c42-08dc8fbc24a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?OmPu1O+1v1LT1DZp7hWU2QPA3WYDe2gqTEGeHXXQnEAR9+4NpmafG6zTcak4?=
 =?us-ascii?Q?EYuulJ/ydj8hlWzab/n/e+PfhAsGN034iw4hvY8czce6lVuh+UQ+hFzFnRGC?=
 =?us-ascii?Q?fURDzaxJQm+F3DuSCS2wxuyvWaYTnZYRses2A0d3WUolrBQEG+bsmKUR6EBg?=
 =?us-ascii?Q?cQ0+yIE8M1jH8WbwDOhUpo+79wyVfcbCpv8ey6PShfSh/BjXqhPxRHhpiyA8?=
 =?us-ascii?Q?Y1BgRoVBStchtc5F5QRIPCsJklrbYU+qg+uNFlIDjVHzBW7xq9EMBxkgU3WZ?=
 =?us-ascii?Q?tbbjqYAi8uAJQ4jnRTzWUSAY4g+Ulv+iKlMDFXDosnjrdBUjUWR9jEPEbjkI?=
 =?us-ascii?Q?4pSJVgTMj5NEJ42KzXNf0AhGtIMgDaXm8TdabwH8i7M9gMPr7wkT/Aena47B?=
 =?us-ascii?Q?lxEFBfvVcZIeOBH2/BSQv5y3TBuuPRFOaDGfRALB7vt6yOQvPuURJlTLOs/I?=
 =?us-ascii?Q?5LPtJJJi2Oq2RwR9JuR2OzpTLb5K/gBOvLbEb/3kUSipSBXMRntsEHDZqyWp?=
 =?us-ascii?Q?5XCJ+2Byd5L8KtpNv8RNpxmrXRhqFtgWC8KP9+QyzLuQ3UYcmulWwTvknMMA?=
 =?us-ascii?Q?3nkrEK2sPRfcquniXqdnUzrNtldKw0ijpdBcGIxHf9JDBeeVhenE/4GnnbOp?=
 =?us-ascii?Q?eaaV4ClH8+FZZMj3gbGm5OAqAOLLzvt0GxmSBVWpxloC6cV+fehm43wyERkG?=
 =?us-ascii?Q?+s7EVoS3Z3BOXOjZ1IMFOBsEH2+fEpgZ/atH95G+7eVDKvmLpTcC2WPyEe7N?=
 =?us-ascii?Q?qrz4/NGC08n+/ZsD+627MO6HsSU7zfePm5t8pGwNWVLT55w7OrGtTv8w5iSe?=
 =?us-ascii?Q?iN5DSZKkfFUd/25mJhWjL10+9pFu6V5GfGECMHf8lM7bFcoi0qyjs/RwYtLF?=
 =?us-ascii?Q?ia1f5+uqwcN12pnXoOvxbDfZiJLzkhcrAWFjob5gyB3Aopa4wsiMXSE6dl9o?=
 =?us-ascii?Q?hClYFXmRo32rfyIEUjkcYPEeOZBzPrViVPmbVwzoswUheAbRbIPeKJQ5F58t?=
 =?us-ascii?Q?OgGiK3vXKEv222qiIVMY5SbiRYCxRmhsTj4M9+W0gxNGYwicpiUx1CpddfyX?=
 =?us-ascii?Q?Z+N2GUJGDZe1hYhaxsT00PyTZJHkXVz+VcAFAf6go7ozsnd70R2xKjxpf7fb?=
 =?us-ascii?Q?e8m8M6EQVgieGAK8LKUnOVlprcbDFlFlyXRd3y2nM52XoJGOtjBqEYk7BJlK?=
 =?us-ascii?Q?cqyqpMsZz/IBVGKlwiutcQBEG+M84dEGAUQ4pQywk07xmgzh80QTuPuuGwBB?=
 =?us-ascii?Q?uBhdTiigNB6DcOEcx4+uA45uPssm0Rt7PhdCIud2PxUjkig9XYPwvnG6a1w4?=
 =?us-ascii?Q?K7jLfr2LnsSlb8FH3bqnDokG?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR13MB6372.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Ac2SPDOx6qGM/fAvFC7j8T00+kOqTp0XyHMrxs+cBtcbYqmCDIQOIeWDI7uk?=
 =?us-ascii?Q?/Lag+Eg05rq/NtndwoQl3rKubBkUUrhTbycT6JimCb3n2WNJ4vzOaM6b10ka?=
 =?us-ascii?Q?X8mUz/PuS8JNhq4UrLeG/zB5F8CiqqUHSnUl6wJS7C4ypVLzA8J7sdxwTdr3?=
 =?us-ascii?Q?Ed57bY8KefKfhakYCHkwYRPAG8VL9bpxfX3IxH+j0SyN2lktdRjjMV3yd3C/?=
 =?us-ascii?Q?PpkbZnlG9MkS6q1dvvDtZ18TxSzQglLyaNjiwnzpZ4vOFNu3a52iPlBYgmyL?=
 =?us-ascii?Q?6dZP5Aownlq/H+PJnnga+1SQASpuwCQTiOo8eujke/ZDGkTHWEcodlim/BMU?=
 =?us-ascii?Q?X73lDFSim7MhfDstwodBJ4VG/ueTH5q91gQhzwC/O5GhIYu6ngmgT6W+hnVt?=
 =?us-ascii?Q?urweqJUZK9d+19+vyS2KJfUwfVrpR98qtc6X/CTPNZGMQnQoaAci6M+o7W1C?=
 =?us-ascii?Q?Mvxa9agQLzLS6ljFXYrq+p+BNg29Dt2LIQCCQPIok5R8xL0vOWEpjHbwDmGy?=
 =?us-ascii?Q?0j+uGRgTW/0yZ68QswE1TzWz9v4uKgKiZ6GyPTxQl/8KlkgTEUYd2V98hw0d?=
 =?us-ascii?Q?8Q4AJz7BXbzh3fxbYaAHDHQrS1kpTlB9ivbD5YEMVU4bn6SvrXaqSi/H0RGd?=
 =?us-ascii?Q?hZVTV5d2eY6RfxOFpe4DmNJQdtSr66moRn3aJVoZd+C6tTx5NugRiLXAdEnk?=
 =?us-ascii?Q?CNCzEdcPT3Jar2M4KN/cHmP3WUnGeujVTnluD9kiIyQQbkQa0yW8e3KV4Lby?=
 =?us-ascii?Q?eJQw7PPZMgzSeAVjEN5pXtk7icFdtReKrI3HEhBBXTE+8fW62dBE+PUngsug?=
 =?us-ascii?Q?4I7Deq2mu9REm+s8PiotD4Esl29ikBFB5IfyDGQSj1tq0yJVRH6XXT9oFiHp?=
 =?us-ascii?Q?a+VaX3rhLHDgF8jRV2EhDEdknovHPZHC543RbBeCG321neq0Y6ZLpamD7QYT?=
 =?us-ascii?Q?775HN2hoxdHP4+Av6XfjQw9pJWZOvbbvLFdv9cE0mbBUKfVG84VUZNnyyc9R?=
 =?us-ascii?Q?5DaMAnDhbVMF1QAmcj68cL73WUhaeZqope5sxYjNAmgT4adVQc0iMfACVK3f?=
 =?us-ascii?Q?v5YVSOHzdCqPeDUXh+9L+0LykdPTT8waoDn0jhf8uD4qa+3zkH+Y75lSP1MI?=
 =?us-ascii?Q?mt2S4XsrnJEHG2x/fY+iMOeO4fbDboWKK28TVnMA2SOlsKdd9hN4sUACCruv?=
 =?us-ascii?Q?Jvm3JcSnNe3/wtZsLqtPQeii5oB0GoSJg+lXOp6lgs35KSd7F0RAr/oSly0O?=
 =?us-ascii?Q?2MUAgL6skTG+gv2IdLxEj0QMsu6HEi/ypmQcK/n70L6q/Wz1Ohf2vB9/Juy8?=
 =?us-ascii?Q?DfhpMIgs4et+llLBm7gJEUhIESt4V9o6e1/CDV4cScRYIjLO/WgJyp36zDLF?=
 =?us-ascii?Q?d9m4EPCylwYMdY0v7U8eRrmL4jtgMkWEpfbOBgxGvyF4Ns800tkR17B+Stpa?=
 =?us-ascii?Q?gFtaLt5ibqoZQVXg7yA9UdQ24+Okuj2oc4etoDXuENrd9kOEpNMchM+gE4lC?=
 =?us-ascii?Q?McDPyLpg03ZakC0HmpkV+lY1kHwsLQJs4UgSUiTuS5lr3YcnpD6HLyORJDfK?=
 =?us-ascii?Q?es/t2QsV3CrxHntz370=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QLQAgTDOgzhZwUQxzKaU3+0vXoJ8u02J8FM5TAL+bSMG3phfGXIX1YsswRbjbS5JLJSqLYoBoK2o0iDXsWx1GScbmDVyrQqs/cHsA8G9K/GEbVN1CXgLQwFug4T/wawIG5pkKlfMmNC7L8/cqjAHovPBTG9EvGBITv1hrwM+C6CkzUCIovhoah8EDnpXzczzwtjO2+4qCj+H+T10U/oHLn39ukwrwEBwJUr1n+JksdFT5/LXGLyfO6Q4oBuH9NZalNEe0MTxjg+3VvqBFMGqGRbCoSh+9RPQDqviKXPLRN/vduzYAND/nN1rcDLIA79E8bRdveORKTTB8fRFhwF3z5Q6KkGqvW4a2SI4d7sCsU6vA2kiSOWB5A4uWvZe3Ay+Mfckq4uSRyISZMor5bvW+liiWdJVROTJSYIhD87XvpnPw0h/xJUFr9fnH3HkrXOdURXFRHVlrV7JQAqMx0ajj9c0Wqb7sX4iAwQE2WFHI6Z61Pbx5ZTsly5hxtG5R31f0fJbaWqCxz3Ty7cpckjcbWmx5SaJll2Bx097zP36h+AIHQ+6Xqm/xMPS7wuefru6bkPeQtPeOBfXT0V3yPZGsL9ZaMCkoxmmhkIClgdRqP48jtRKZK2hba79ZinUw4bp
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3edfe18-20d0-4158-1c42-08dc8fbc24a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 17:29:01.0829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3msliKZOLL5Hp5Yofuqe6hYSFukhL++/ts0GIM9//hUUDlK+Ned9m94lB4LvmgWhy/MSS1dsStXntvxrKVAzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3739
X-Proofpoint-ORIG-GUID: lWKuRUwE9o1wZdo5PJvlabdl8bz_rafa
X-Proofpoint-GUID: lWKuRUwE9o1wZdo5PJvlabdl8bz_rafa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sony-Outbound-GUID: lWKuRUwE9o1wZdo5PJvlabdl8bz_rafa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

> -----Original Message-----
> From: Laura Nao <laura.nao@collabora.com>
>=20
> KernelCI is hosting a bi-weekly call on Thursday to discuss improvements
> to existing upstream tests, the development of new tests to increase
> kernel testing coverage, and the enablement of these tests in KernelCI.

This is interesting.  Is it possible for me to join this bi-weekly call?
If so, can you send me info on how to join?

> In recent months, we at Collabora have focused on various kernel areas,
> assessing the tests already available upstream and contributing patches
> to make them easily runnable in CIs.
>=20
...

>=20
> *Boot time test*
>=20
> - Investigating possibility of adding new test upstream to measure the
>   kernel boot time and detect regressions
> - Need to investigate available interfaces for reporting boot/probe times
> - Multiple measurement points may be necessary, need to establish a clear
>   definition of "boot" first
> - Influenced by defconfig; testing with various kernel configurations
>   recommended

I'm extremely interested in this.  I was planning on creating some boot tim=
e instrumentation
and a boot time test, this summer (before LPC in September).  I would be
thrilled to talk to other developers about this (either by e-mail, in your =
bi-weekly
call, or at Plumbers) before I get too far into it.

If others are working on measuring, testing,  or reducing boot time, please
consider joining the "Embedded and IOT" micro-conference at Plumbers in Sep=
tember.

One of the chief topics of that micro-conference will be boot time.  Please=
 contact me
and I can let you know instructions for submitting a topic proposal for the=
 event.
(Or just submit something at: https://lpc.events/event/18/abstracts/)
The instrumentation and testing of boot time would be a great topic for the
micro-conference!!

 -- Tim


