Return-Path: <linux-kselftest+bounces-24442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C844AA10510
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 12:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8BD3A6492
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3204822DC51;
	Tue, 14 Jan 2025 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EIKMlTJo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0GS4K68A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6C22DC37;
	Tue, 14 Jan 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853045; cv=fail; b=AKR5mc+WX/jNx2Bzhv8ilzkps6vc84l+FRKXrmHxq+iloYymaOKa4QMOAGuDEVmIFPq2GZ2aFX0GXp+O4isKZLfxvBGLE2hsSYtuVReIm0Eq/aYqqmorE2/R8A9sP8LMk+MQgXvKDLw8hYHYqEthj0tEvTVjNTrGQ9VzwA4h65Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853045; c=relaxed/simple;
	bh=4C1+1QkiUrj+95hReVfNHXlKmGiLd1ESuQv9BBE/kQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VSIWLek62g5KHNkRzaAwU+YQdxYxkBgW8axhuPP5udddIWibqt6WbPyCfKanfIEHyKsFxyMcMpclNG558A8CRsDt40oy1bpeiJ/QFPUMZFjLXbn+r2H5yiyOe9UW4VH3Ze0EwtYfFUiEpAYdR3d7h2AMr+YAkJaGSfJ58RI24/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EIKMlTJo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0GS4K68A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E1Bq0K003891;
	Tue, 14 Jan 2025 11:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=c+OKGGDd/pcIO9oWK9
	N5MZ3bQrh4WrkgRIdh7sqnPAE=; b=EIKMlTJoCdoQMHrwwk2mavUT5OgRCjtvMi
	jpVnybdk/erkvSKpWHeXPcVbijmoS9VIlHeWhwe1nPTySz7u5f5WyVgv0+MUptqP
	fQKvZpb1MKlvTW+4bTuyHwMLv48onijiXGbXXszHSyTFLnnuawr7+OhkR+3/5KN0
	BWB4NskVZZaLQIjIRUHVSz4uSKw9IVDejEp/na8jGRAMi8xqR6wG59zEi148aBRB
	99nnp1N72BJ0qBQrFOgKphI19iAilQkgS/FPmzB4puhEQv5dkNDVHq6+A7V6hhln
	daLV2/3XqlJypAzGOB9ipVGjd5QGKxohI+qDjIvktnV+DaDzMt9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y5gta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 11:10:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50E8cN1U034845;
	Tue, 14 Jan 2025 11:10:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3820wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 11:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jklM+yJtvnqgZoHwniDvW8cfzGAYyFhEW2O1n4I0JuFvZwIJG9tyVEBVBVexfpc/4uMQGXAi9BmhkPRTelSHLfd4Hi0ejJWmiJ8zYMAssTWp4/++Kv/of2jrZi4lpb8bJRHzvoNaE9FVO/CDKhb34obc3UvHgrjt6I7fyGB8oHcs4IYHQEXG9KHPBHoHXp8RzIvblwjJZ8qj3DYVIkhvlfwBF9jOcAff2Ly6h1ZEXDKOVxc+bpAC28l1T1tHvk+cGp5rUnbLnzTYeeiZP3CIMICt/MsKo37h95AtFYyC85f3sidXm4/yHmobGXxz7tP6VaMVRtmOwZr8lT3yPMbRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+OKGGDd/pcIO9oWK9N5MZ3bQrh4WrkgRIdh7sqnPAE=;
 b=p81JOrXCWzXPur8lwRnAbpgSJPD+pLgKDYgHnk5zmM1ZOEA179ll65OGbedOyX0WuwI9KuYh3Kk+BSd3m6lW8CufCx66nXEH2kUHKIggX5yHcbHbX/C2yQ/jxT1Doi+NCvMgwn5UW67RlWdgWmGEB7ab9v4qQYSZx7zOZrOSDxQm8P1uWxfTCViliZ0mQSc4YM5y8GknO7SxCajVSlA2UrCwEyuF6iTHDALicL9VtDlLsYJMPcZJSaQvxRm6JbmCbWmK0Ve6/S/NjvueXIWMnOWu+Tb/h8947aQxTvxcX3k7NSBnjqIo+XLjHKY5THkQp07fI9wU0UXivvvTRa2UBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+OKGGDd/pcIO9oWK9N5MZ3bQrh4WrkgRIdh7sqnPAE=;
 b=0GS4K68AxNgdkI0o7xiOvZ++wRRe8Es/EmPKsKC1zLsWpI2b7mu4kDGGQNwW5LuPn/CuXCq7NFmBNAM+viyq6fFX/LY8w/dYdAJY5ryHEIyl3BWioGDxohLHvUUd3ngqRGLdyS4fLBuFtDNKqVK6lrf27jA36H1vlpWsCUwntKs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB5753.namprd10.prod.outlook.com (2603:10b6:510:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 11:10:30 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 11:10:30 +0000
Date: Tue, 14 Jan 2025 11:10:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: liuye <liuye@kylinos.cn>
Cc: shuah@kernel.org, akpm@linux-foundation.org, jeffxu@google.com,
        isaacmanjarres@google.com, gthelen@google.com, sauravshah.31@gmail.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/memfd/memfd_test: Fix possible NULL pointer
 dereference
Message-ID: <51b0775f-0268-45f1-ba81-585d1eff9a0f@lucifer.local>
References: <20250114032115.58638-1-liuye@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114032115.58638-1-liuye@kylinos.cn>
X-ClientProxiedBy: LO4P123CA0117.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5acb28-61f1-4f6d-8be1-08dd348c0e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rej6WeaygsyK83L68GzmouaTl9/22yWQYWGmMXPPMOLDBl8gDCmjGqP1TloB?=
 =?us-ascii?Q?sP7CbCIxY725+UG7sFq5gWyX+UJeC3k/DsEJvTxpmmN29Fh7WRSgLTMa+bNJ?=
 =?us-ascii?Q?CxZ1TZUvj0/Jgl5LWmxP8OCWKSvs+68UZtM3HrtHESnz0X5sps3cqL6ICe7F?=
 =?us-ascii?Q?vlSoPiD0LNYE0+H7BluvtqOThWY/GaXrlxr3icQSa3h4UKyl5gq9dVL+LOlF?=
 =?us-ascii?Q?baWLllzDuLLvY3JK/8OVzeL3RiPDkVX7nzQwwfOtlm7MZrlqPRvFWyF4fZss?=
 =?us-ascii?Q?G2c1zImxkf3atNW/sbV+lGIe2eyUf8spDogIne1AygzNc4c9PZhZ1KsnX1EG?=
 =?us-ascii?Q?hbsoG5lNM+GjCSMZEEuN6JG7V5pcjyZv0qKjqdDJ4klf+1swR1aENQTWLsi6?=
 =?us-ascii?Q?Hxzxx1sKqQ4V+9hMLFVXTvS5X7e2OitVdLFT2nANNSh+4XinIfxlSDoWL03B?=
 =?us-ascii?Q?TBN5TTXNpg7L6bjH0D5/0eIlh+YenEHw+ElTpyKNAD1Zlb58Qw/ydSiWvI2c?=
 =?us-ascii?Q?wQxzGcgWkimoptJBDKilfVMt1YdNzl3oJPH7tE0fYdNl7MFG/jA5N0z52ZIV?=
 =?us-ascii?Q?OuiMEXYoIcIfRANjdx90zKTE6sDrJteh4Hu5Ui+kIA3valkI7N+l3Qa2byV9?=
 =?us-ascii?Q?7gLnamauhppyQnlz6Nl5uCz4Qr9jFrFmB8ytVce4qohJ+Dg9LYk/tOVe4xQz?=
 =?us-ascii?Q?eCvGgo/mkBivcKyU5ifIuB5ay23NKuilBlVxSLKlFFyXJH5ugPwFeJlsigZZ?=
 =?us-ascii?Q?nKkDn6rE15RRjvlDcyxgpdhg7KDftd8oNirvGqjXoIPIIhtlElygLFfBNobL?=
 =?us-ascii?Q?+udVZBbpT7Hp70Mz8lCc8Fpn6jngJnVWvYVmmDNZAlVM6MY4paRZTLp4Ec/J?=
 =?us-ascii?Q?7CiSEkqX5mbs8hP1Ct3Ab5gJBS8YYwUrWfBmYaBSB+qIJspxrDsF3ja4hRfT?=
 =?us-ascii?Q?17Op4Dqm+QzC0gDX/t7RHj6Y880r9gNUtnnU0XVt7e3cj3ugRNV2qW6HnLkP?=
 =?us-ascii?Q?XsHUOYmRI+Z0pQe/MOmDw2BJz1gbenaXa7pvrThm9VAv76xvp7s6MVA4ydhr?=
 =?us-ascii?Q?uh7bJV9SQ7MfeM16Rq+d9RiFLOh0UVUpB8TRqofDxR5YpgD4DbJVbxBxqgul?=
 =?us-ascii?Q?E7UMUaZ7JSoi1G7r6bunRHzbZLF6/wulqXyQkbL8u7RrpVxzXeQCuFvcWy26?=
 =?us-ascii?Q?QgBro/oKR6z4LD0SRJhBIx2IAlUg9S5SVK+2iq5LsMQGkweqjdD3mGe8PUMR?=
 =?us-ascii?Q?Cp19KlciCwCxh5Mb7gPnotknCIjZ6QT7kTUsi3+28ABa5r9YZUY1NhxVQRjT?=
 =?us-ascii?Q?D/ZphspGxNA3Er/6+ySCJ3juTj0Fd9aLwubjW41SDwr70FPI+l+XQi69k6NT?=
 =?us-ascii?Q?wdyeUq01qzVGNLSIyYpgC0JmxjY/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+mAddr9vP6AYtdsMj/SVlbveu7Uum8XdSbgO5Ib+Wsuz5/y5Fara71vv59vW?=
 =?us-ascii?Q?kgBChNhVfxx3HZkeJ3ZJfVPbhWg5Jj7+O2IJO9z5bNoMnCFQfZUARbWAwcUW?=
 =?us-ascii?Q?TujxT9o9qVWN0RFp+K/3HUntGY5GQd4VORuBATH/qMcejjBe3IEbMQW5+1BU?=
 =?us-ascii?Q?4PY+Smkj401wPy7/gsr3kuOzQ0fS/Gk5hx7wRObkRnK1WcOUIaal6U94epBj?=
 =?us-ascii?Q?zP55Xk57C+pBNJh6WvZ8rumtFzNC/ga9bl7MMAOKk44RddD9sWzLFjm2sF/F?=
 =?us-ascii?Q?gN9DUG/adNQYWq70FE/Zcs+TX/BgIYE4hAaOeyfH5I6IsNv6n4rHeDjCwe3X?=
 =?us-ascii?Q?Byk9H6S4Zvf9Z66MHZ3jmDHuflx7bL0U75r3+hBSCN1g53MhsznkNmV+uub1?=
 =?us-ascii?Q?ONmUdTALanOB02z4hCsFvYH+W1N35jJ6ZQmmlIOZfad69vQh+xu5/r81g4fQ?=
 =?us-ascii?Q?AO5eHz9l4U3eXLSVNzMAt7aBoeJsOkGeK9VUePWA2ZyJTtTMpU0gNYIXFcBb?=
 =?us-ascii?Q?OGU/X0AGT4vPkJa/p0DrYJFPxX5AU9j3XEZZj2F8r80yBzOcDaI0syLZG9jJ?=
 =?us-ascii?Q?OSB2GekXSW3UtR8U6pOxlxLoINa4gSLWGk9PYwDRKyh8vBGnwclBtxRLSRzu?=
 =?us-ascii?Q?oTgd+3c5EhojvhzXV9Pxc9duSFIeismAwq+sQUCLwcSQ/4HhfeoKZgf+vlqt?=
 =?us-ascii?Q?Eev0pD/kgYIOaGRXxF87O7hX5b6QNIB9vvTfQNVeCEanT2Os63uCNs/RLDIU?=
 =?us-ascii?Q?gEUXSomLIYTGmqHMyUY+RAwcM689McsQt5LIdeKX4q2RYoZuXDO/NDTwmgYy?=
 =?us-ascii?Q?f/8sEb68890Fohk2bzVd6TflkmKvOidBsBc5tqRdp99tasNZwUo7CY4NmcSr?=
 =?us-ascii?Q?J2fYwSoLhvOtoCN9S9IZTT3g2jVwt/V1XHsgFIEf3/JoTvUSU4+M0hPEbHiu?=
 =?us-ascii?Q?OyEi0Kt/P4djHFuWT3HHPRYV9ph3gYrBHcDa+QuXc8leWv7rse4XLEpBi8Cv?=
 =?us-ascii?Q?M0wA2qbPku1Ed+/sxJ0yPn3mzHhmxhEBBUbvXZJBYJdd9XMPb/PL6Tj8I5lk?=
 =?us-ascii?Q?712kMEpxPZllZoLjHq2v1XVlYN8/KnOmKYjIilUUmFglj8kQJosKzpgPrLcg?=
 =?us-ascii?Q?qujw484lJDZWBLVxuymbsXSw+m81eag4Rnmw2UVJ/5lfvWTefRLs383/O6UB?=
 =?us-ascii?Q?BQWUdVD6IutjzE1lBfwbjM2n/EKAR7Izi3RAOhkS/QPNbejCm4nda+junTYC?=
 =?us-ascii?Q?Ag1wP+v1h5lvQ9hv/x9YgojnLO+Fj4YLgQKx8TBJZ/y/8Hsq9wjzuHSL3CLl?=
 =?us-ascii?Q?vPNFMgwyF+/iqwYz1EHVylEhZHLzaUP3AVuexUiTOUhOfziJbrL3jruyEMCJ?=
 =?us-ascii?Q?yXTyGzGZbymEe6qTz0VED+BYHcJhF964CXvrUU4oSNNv/56LMd0tzW75Vy+H?=
 =?us-ascii?Q?8pU1Yntvz9nT1XLTzQUjYlSPrxWhYT6hDr0uww9dVHx/OhMwCLj+HJqMHqX1?=
 =?us-ascii?Q?lXLj/lpUUorwqe83pK3CnKvxhzryBjfXuttgFPozP7EYP16h42wbMPoWYT8U?=
 =?us-ascii?Q?JCvLSA8LskozMa3jfh5GPdKf+V2Vee/GlNlbSR4wq5znE9O613PawDA7azcl?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	agzoTLvrRXlV9OXs83AScKAsBizB6sfnOovXnHXMv/vFylVY2QA2qmM+cEy5E590EBKQYsVbXDvqUeKXJAyX9kjuWeQvJ4lmP7WISKx4BuGZlB1fMAF1xok7icdzztyEi5YowDZTCp5J056fayv4qNcJ4HmfewvM8gf8mGTF+3Tl6cidy+QO4Y9eyojOJGLaK7Ww887U1mJtoLMFayAdG27VJOPkN3L46RCLjKSough5d5wkviKZm1dUrS4L9NwO+nQKUCB/Yq1H2ZQvZAjg2yq4vE/EgDZfh1nM1BKgUUvpGkhh7+loQYJ44bdLnX8U70Smyx0028EQa3OpyrlYBZHVEb7K1a+0+nQz52/TYDJP+fmKQmcKUaAijbYqE3YSSafg0u2mKv7+yKn0iEy40N+4f1BxiwJ2wR6qNLu5MvsXUPt4RtsIwZ3gmCLz5nE+SqXBzOQat5jzEir3ygiMNjGdtDu7T0qZ51+bLtnHT/XULlOyM8KT0vAxStmNd9pGWDzDMpBNwzdeqvdhT+jORFRbQYVMh2fOmO3y3dwwlalszD8vEnjjhRU0DNVHDI2vVyTNn+BAghABm9zioCh3M3eZQSxZX7J1WvdY9NK59a4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5acb28-61f1-4f6d-8be1-08dd348c0e8f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 11:10:30.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMQNjbzrE7HRVsiYWLPSBHU5GAuf9/uzE4Taul23sxQGKOcJutohdrsYXtZWoZovK1yVgVD0YrxkmZacMUx1TVjYlscH038cJCm2EjDe8ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140093
X-Proofpoint-ORIG-GUID: trVpuHDa4lOpdPiPvKaaTujL-LrDUgBU
X-Proofpoint-GUID: trVpuHDa4lOpdPiPvKaaTujL-LrDUgBU

On Tue, Jan 14, 2025 at 11:21:15AM +0800, liuye wrote:
>     If name is NULL, a NULL pointer may be accessed in printf.
>
> Signed-off-by: liuye <liuye@kylinos.cn>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/memfd/memfd_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index c0c53451a16d..5b993924cc3f 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -171,7 +171,7 @@ static void mfd_fail_new(const char *name, unsigned int flags)
>  	r = sys_memfd_create(name, flags);
>  	if (r >= 0) {
>  		printf("memfd_create(\"%s\", %u) succeeded, but failure expected\n",
> -		       name, flags);
> +		       name ? name : "NULL", flags);

Damn, I was going to say 'oh hey we never pass NULL' but in test_create() we
explicitly... do. Good spot!



>  		close(r);
>  		abort();
>  	}
> --
> 2.25.1
>

