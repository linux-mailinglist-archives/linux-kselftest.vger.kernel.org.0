Return-Path: <linux-kselftest+bounces-26999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D448A3C463
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC9E3B536D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E76C1F3B83;
	Wed, 19 Feb 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V7ZxBpy3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JaXtAnMw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ADF1EB195;
	Wed, 19 Feb 2025 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981008; cv=fail; b=pk8/3Bd2cH8Qkb3uxt3JSxCosjJ1uPwLkW3FJS44mJq+Bk/ANzQWv7orU+b5TtY5l2nVbC3wVgRvVrL6IsLh4KihlmpxIuMHkGUzB3nxtgHtm26c5yYOkXaviruKGtp+eb8x+Aj7s5GUNpPrIBXg6cll60u/JC+USGVk3/4vAkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981008; c=relaxed/simple;
	bh=aLjop8erCGIlXh+5TT+m3fpQNAGrrPNdhfZE/O37WHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XKEZCoev/6nxbCl7D+Hs18izZO38jtnIjFsUAd3U85QWedNL25FcfJ2mKVgQstuJ9b2Yn9FfpWnThkwqph+IuUno2S//pJ4EhAkNdqaf6T5O8jQwuI3PBMHzwAqVVQX3D/obF4uON3qo19tX/4BCpobYSvL0Rd3HAFsX/83bp94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V7ZxBpy3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JaXtAnMw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEBY5n004306;
	Wed, 19 Feb 2025 16:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aLjop8erCGIlXh+5TT+m3fpQNAGrrPNdhfZE/O37WHU=; b=
	V7ZxBpy3l348ODCKl2LHdw0Ynz6yjhXAQAs9xhJ1hByYYCHeiD72FNcxcA/d/A3c
	55xpNUUe5jwSrNUS7OyEZyw+cF1Thy7uqrf+xCPO/Nz/T8p1Npanmj9rMaj1Mo6I
	gSFTBdMO1XLtsXpkvY+5ItOhuvhnbornqete7M+kocVFpkKp0GkR+QDvGM/UYMob
	3iSRAdx1PpfBt/ne4W+s3qNWu+3p5PTVFvVVb8sz/M7G66uhL9qd3GOyF7ua5akD
	A3YzS5y9nx21SPAGxkxYYVj8jpQQ/3g+a3offyEJERoYa6fBb/1iG+yZY1cS3Ct4
	PuqJ16y0tnHcvF2erOzDwg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kj0ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:03:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JF0jrD025201;
	Wed, 19 Feb 2025 16:03:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w08wp72h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 16:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgfauVSPLlcMso4kzirFxRaZCrv4VszJAxE11mbajQlSDMqzAX/q8THnARrvUUq3CKdt2iunqXifnwefllDcU05qOEENGtwyNdufqu+rEt9rHY6KlurX4OT3KstQ2z1denCKvkLyMvfRXgs6CF0rTx2BGqZAcbEDBSjyFI0zmzqhe6jcD9PIwgpECpcGq6nUqj39XvvL/VGyPmMElNh40uXfQ0dG2lvNBMlPs8Rh59GaZ+0p0yPqxPLkIUOQhG2MkAa86XFjq2lavNhufIhmk55WoPktKxn/gic9XpaFceL/wt7Ee9yBHRhxzYWloN4b64oJrifZ0oYIluEAtKh4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLjop8erCGIlXh+5TT+m3fpQNAGrrPNdhfZE/O37WHU=;
 b=epaW/rXwViQ/ix37bBZ9q9rBQ1ch7T+OfQ+WfMRcIGX/faPyal78PxmQpiMuAin6wy1V7tesKJWynHjxWLaKvMcPxDs8E1ZappI4bDeqzBA7KNIuy2o1xRfQeKBT12w59LRpQZng/ikytbbRtOjY2lQdzVqXRUpivj8hiEVbvg3ualc5Hz3bmT2qZSaj3kMqFajavJ049o94udCfHGFtVsqfuyrhd50UFopMldmBJE18drujd1rgy9VKekeQjxbkoaFEQC45wtyMHclV2E3y0TzUs1UpSWUKfQUE+DpaxgzU6eHLWLas0nuXgTEFaM5K8veMu3SjftnviJuognQq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLjop8erCGIlXh+5TT+m3fpQNAGrrPNdhfZE/O37WHU=;
 b=JaXtAnMw0k1Gn/mQAyw9AtudZVUYYzocnHFuL4xsexz+7ga7Yt58eqFSlqzxLxgxW/+AOfuFurSVmZ+rknAarBLqIP/mJhORae+efHB+UPYuSfP1VNC5/YF072TSaw/+R4CmUqTjabor7k4iPJjcjNu5aQJdBVTzW0lGjH04r1A=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 16:03:07 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::10db:799:49cf:f735%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:03:07 +0000
From: Chris Hyser <chris.hyser@oracle.com>
To: Sinadin Shan <sinadin.shan@oracle.com>,
        "shuah@kernel.org"
	<shuah@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
Thread-Topic: [PATCH] selftests: sched: add sched as a default selftest target
Thread-Index: AQHbgpobAwexZNUbBkmXCDWzivovC7NOyXu2
Date: Wed, 19 Feb 2025 16:03:07 +0000
Message-ID:
 <CO1PR10MB4705D8F60A86C711578CD3999BC52@CO1PR10MB4705.namprd10.prod.outlook.com>
References: <20250219064658.449069-1-sinadin.shan@oracle.com>
In-Reply-To: <20250219064658.449069-1-sinadin.shan@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4705:EE_|SJ1PR10MB5931:EE_
x-ms-office365-filtering-correlation-id: 0249f4d9-8479-447e-27b2-08dd50fee664
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DCUstbnHz3ZTL9nYIXTUQ3oLw9fgsttkHQikqpEYu7tZULFdiXdwOQrqep?=
 =?iso-8859-1?Q?jweCYRkNC2yyAPeWDv2o18WVmZ3LqNzdZtgNlrrjB9uZR0VWahJvVnrt6L?=
 =?iso-8859-1?Q?XxBUoq6l6lsGSFLRv2g5HDFKnZs20PQpPaXKhcu4vwWgn2eEY6dOp+GaGt?=
 =?iso-8859-1?Q?tOOckZ/cVdxjRnGRrFtNz0HnxINufH+H2jq8NZRzLtAwlAJf32t4z9KMCZ?=
 =?iso-8859-1?Q?3OEeP54sRwgQQ0gk6+cH5bYwWsIMQ8UpD7rI0sFC3yeFavsv7MF4GEwIuE?=
 =?iso-8859-1?Q?rCVbDT/7f+r7QYIII0u/mEBpL0qHkg9zi7RBV9VJNIWKyLigLELAyul694?=
 =?iso-8859-1?Q?Ow9QiOQYKrcKcWtzKyw5TrlvwwnZybXlADBlyi5+gxe2eHkyrbPP5hKxwV?=
 =?iso-8859-1?Q?xDttmSl1YK32/Ss4gR0AQmVQ3Gt6KV3on5LU5iTWzhxSRWApDQkNmLvSfJ?=
 =?iso-8859-1?Q?sEGD15f+Ab5PoFMC9Gz6Oe4wwzvi3Hk3KfknzE4wiPn3u8ZwPowkTdUZuW?=
 =?iso-8859-1?Q?pEEvAlCKyQhLIrcMBr0bXT/FVtM+vG23rakLSprUZqQtR6sj5RiS23w5LV?=
 =?iso-8859-1?Q?kdqKyQxpqaYladSwZ0gR2ew/iX3/wkKfa52myFWSixQQoJ8cB//Xqoxwb/?=
 =?iso-8859-1?Q?UMNEBnZwjCYrxNy0y2wx+yIS7ld+jx7wKosykZ2lsjC/uWgrBhw915UFUr?=
 =?iso-8859-1?Q?UopXIE874Eev3QUjD5Jrje1sEragePOSYJfxQuZ+tpmz6Z+jzMHhAjAMYg?=
 =?iso-8859-1?Q?U1fDYMw8GOb/tfeRDDx5LoyDbc4FqMn1a+UBjBgaAxGX3R6ayu/aDmERyo?=
 =?iso-8859-1?Q?qcVLhbD1fqA30RpKSDuIY0wwYaaDAx9j8mMjRoj4a3B66Au2l1J6vXV0gA?=
 =?iso-8859-1?Q?0Z+BiihjanGpSoMVsjbf8f7llsL6o4C3Lv8r9Amg517ADNuhMgUs7pSTyx?=
 =?iso-8859-1?Q?Dkd6SRmJ5tGE8UG6MLyO5qxOlsFg9ckRx8DI+wsKK1QlXbtKdIilMNGMCi?=
 =?iso-8859-1?Q?hrR46/COG88KhoAcBKL7LJNq2kOfd3PnGEvI5zpRy37ufI9BYbzuMKCbww?=
 =?iso-8859-1?Q?D0Hlj+qZHSix6MJ8MhR1M5JBLobdzu/yS+P+VI8MFhFwsehSb+CqRfK22L?=
 =?iso-8859-1?Q?0Agxq2LOX9QnRtu2gybwp8rKPRcVG9uPIj/6Txem3kXhEe87nyop/ZYEEQ?=
 =?iso-8859-1?Q?69Ge0eoh6uBOhpDqOdW4wYfhfZrgAH7etSSUkylTjnqQHE6FxHfoUqT27J?=
 =?iso-8859-1?Q?+w8Q102S0hkNjujqF0GJibByI0FD55mttC42f7FgXviWvm5NFaPbagyb7r?=
 =?iso-8859-1?Q?V3lUe6A39RVXjYwawjnYkYh7N1gHp7JxziuOhdE4SGGJ/9r3Cb53zr9qe2?=
 =?iso-8859-1?Q?vHNq6s0BEjevFULvhnBG5x0Fzx/UHYhsvl4Wz4Yi8oOLl6Ho3LTPrqNz5Y?=
 =?iso-8859-1?Q?Y7aRaC2Aor/QYwxvgwNHUXugKjPncSByW3mAGl6YTVV5u+Wx2U22oMDNze?=
 =?iso-8859-1?Q?k86gtef9BdhY4q7BrOfynf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?T5taPa2jjUloENUT3a3JBuxtHVQOOX9hsfWtMfAEF2Xd8y2VAeyskZbsab?=
 =?iso-8859-1?Q?3F3peKk8lFMTWJj1h73gI2t4b1ajwYyELFezOdRX/3iCxymOXYawmCmluf?=
 =?iso-8859-1?Q?dNbGb7K2xGvNucccC60ao44Kd1lBpN6F+M+iYvDJsq9B0/Va2Lge3UX4PZ?=
 =?iso-8859-1?Q?La/ywd1PDB1PYnTCy9gNcXj3C3qSwnUl5kt52g+l0SGwqXgt559gZIHuQx?=
 =?iso-8859-1?Q?XzTDDLgjqWitk7eo4zDjeAdQwJMqOhICg4yGIYKMmL+Sdh8Zc7aERyfesE?=
 =?iso-8859-1?Q?Xg7E3bEFg/vAaBFm0HNul8M9sACserWUDokv/eiFTo8+SDovWMQUX0Vpas?=
 =?iso-8859-1?Q?RIvhfXGxrzoOxAMI1YR+bKZHU7jTVm4mKNbbWhqachmu/7VhQBVpJxfJB9?=
 =?iso-8859-1?Q?WmNXVq0+vlGKYVs+60zcwcmC2tYFlx+6tu29MITGt+eJhMtT3jrJ6J45+V?=
 =?iso-8859-1?Q?m9k/IptcMMGO5zOopGkY35betkkeDnqFdiguiqwp4nV6RtNVgHK3xRp5Bw?=
 =?iso-8859-1?Q?vnDkJb9ueoqdLDR9F0X0o87RY9JyuehBi7SBT++SNt1HzBGsvuonB7/EaJ?=
 =?iso-8859-1?Q?H/HxaESaH7MVu+mBh0ybZ3BRrZWq9EYURExPUGrN2u1xaPzqZynSOC4CZX?=
 =?iso-8859-1?Q?tcM78lJn8yuZVxRs9Gr21X2zAonpkV7KneliKSoBOtnEPaEXZjpA1M3RE8?=
 =?iso-8859-1?Q?a6X/lKkO5owfnPOPKrob2PUTbsEDRXsW25Soc9/enoYFmyGryG+i3pkE59?=
 =?iso-8859-1?Q?vo5YN9SAwjhXiS9UE+1ie8w2SF0/1rR8p0ODcAN1kYE32mzp8bn4PYzCp4?=
 =?iso-8859-1?Q?R9lgGa7YSER74+TkvGCE35mDP3I379MnYmpnM54aGvAqvrw9y2FHM5NMe5?=
 =?iso-8859-1?Q?RTNWANu8gMbllxlZmfRqe7oVKgN41s7kk824gg1bokw5YuLgBhmQs1AtlO?=
 =?iso-8859-1?Q?/FvFEKcVLHgAJdKWxrGI6CS+H8svBIf3QAZK+2zEl9iLj7rgXpiaMxZzZQ?=
 =?iso-8859-1?Q?/o9fcPJ6GiKTPHZYCNk4eb5fTLyjxkxuCCz2upOwtLRl4WjUKG1cSo7oG5?=
 =?iso-8859-1?Q?pi0TaFeXtC5VfTe6SyHX8ALq7Zmly1VV+IaKZ3F2RJvSprhT2vTPhKVLMa?=
 =?iso-8859-1?Q?zyL8yuFlESiOAYbgFS23OdsCLPTEum2T5g418AyVHxUVUhEP4tBEIhsfRn?=
 =?iso-8859-1?Q?jh3BlOH/Id5Z7B5fgyJnF5x3+Lt3TZ9FJtnlt9mAwPpijxvkSBc4oXIQFt?=
 =?iso-8859-1?Q?+Ka4rytxmScRKkkDZRE/o/kR5mmGcnC/1NtTFDF7ZkNTJkhOWtuGcF9hK7?=
 =?iso-8859-1?Q?FTUfUqPMDNBra0MjC3EbfY3mKvHoX5W2l2zcpWUo6gm4a3ZI89FiSl2czw?=
 =?iso-8859-1?Q?vZi5GshUTpWKWs5GZqYkNesgPKeYLuIoB4otsXI+GoHmjtAtZtW8/RB2qy?=
 =?iso-8859-1?Q?LIrbjadQI5fn8iMsHewD9IQ1OQqLOq4KutnIL58UsnLC8KQAxPe10pBu45?=
 =?iso-8859-1?Q?PhS1nMlEW5P2K9Gh++pBmED/imtVqm6mu/eD6NgISAvopX97fFKzpblE+D?=
 =?iso-8859-1?Q?Rx0Ox1NPGGQreYFkGQj8bxm+q1f/9JaHJ/HCAo5bv6UFzi7QO/ILnzIYmq?=
 =?iso-8859-1?Q?urUHQgaCnwKPlwEyM6C1P69rCnZBaHpc2K?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4RF0x3Or/jcCOQN7vaELMs2d+Rzih+OzMhpqc5FxagQVCeoEX7k6uZe3Q9nCs2oKAgO1pwMkoyGjy9MmE2W0ZIIZP5XQ2Ma2O3wElTL12t/uKSU8A2+xQ/brobSbc0PwZZ+UuwNSYsl6lLKP5NX8MV7WKOB80+U7cIIrEniu51t/lmHFfhssuiL4UwBBsWa0qjLseZWXJ9HWKL9QhH7ftum9/dgRwGn3yfVGCrLX5UM+OuB+ITsnqKMJ/uZ64dr20L5Hi8pSt9hhp7Icv0cgWX+3EV4M0rX1BHxv27g7la2uu5dZCA3nK6jNHC6Vu5yNmP/SSsWCJq3+bdBYSVgjvxWmsqwRF1qHFJH905/93rvmaFS5WZRLqMh5F8iO+EirVgoyyPZbNag43KXwjp9pHv9fFnGHG+C08tVZGsBqolBYga4iFqwb1ihj08MWd3zo5TDRscWPK7i2uMvwLfrIvxM3M/sQ3bR93+lG+2vJLJ1lr7XevzarYjIBxuC+pLTS59nS5Grt/9ca9Nn88N40dOWnuj4OOUBHjwcJ0/wtTq349X8nTITSgymbddPdWAcvAC0T5HFrFoG+YL3oSIX91Son6nOcXuXcpGpzik6FdcQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0249f4d9-8479-447e-27b2-08dd50fee664
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 16:03:07.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /mgSWQuyFmDX7ZaQDKItUW1in5MsMG7L0QcYxmRLmfy4Ftc5cJZIeG3/osox3nrskTTgPUCIg8oe1WN+oZYV6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190124
X-Proofpoint-ORIG-GUID: BODMqKRhp6SFpUMOMk6fggDBi-y6G8uA
X-Proofpoint-GUID: BODMqKRhp6SFpUMOMk6fggDBi-y6G8uA

> From: Sinadin Shan <sinadin.shan@oracle.com>=0A=
> Sent: Wednesday, February 19, 2025 1:46 AM=0A=
> To: shuah@kernel.org=0A=
> Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; Chris =
Hyser; Sinadin Shan=0A=
> Subject: [PATCH] selftests: sched: add sched as a default selftest target=
=0A=
> =0A=
> The sched tests are missing a target entry and hence out-of-tree build=0A=
> support.=0A=
> =0A=
> For instance:=0A=
> make -C tools/testing/selftests install INSTALL_LOCATION=3D/foo/bar=0A=
> =0A=
> is expected to build the sched tests and place them at /foo/bar.=0A=
> But this is not observed since a TARGET entry is not present for sched.=
=0A=
> =0A=
> This was suggested by Shuah in this conversation=0A=
> Link: https://lore.kernel.org/linux-kselftest/60dd0240-8e45-4958-acf2-7ee=
ee917785b@linuxfoundation.org/=0A=
> =0A=
> Add support for sched selftests by adding sched as a default TARGET=0A=
> =0A=
> Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>=0A=
=0A=
Reviewed-by: Chris Hyser <chris.hyser@oracle.com>=0A=

