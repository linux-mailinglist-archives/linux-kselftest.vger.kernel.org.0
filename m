Return-Path: <linux-kselftest+bounces-14868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F079494AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898481F27CF7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370241F937;
	Tue,  6 Aug 2024 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E4/Vwn4c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OyZ8vx9v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A981799B;
	Tue,  6 Aug 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958712; cv=fail; b=IjClyjtSEg6djePHYDN6qIjjTOZIGqZGfhdR2dkMD9nu0Jvxe1WP16JmREXPwt8y5vKAnX8+tmlqEYOAeMZOKuoZA0KjW6Ze5byxCul/+ecRJwwa6SbBApOOl1QseaD2mLKGFDY6XPrHhKYL/V7gn6i/dgeGqHPcuVGtD+ldqgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958712; c=relaxed/simple;
	bh=mZVvzazvb3pjdQAZRSyjE48+VHethQHTNij7gyBNJEo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FZLpEAkMNsPHwB/KrubNSXAcqxeA4M9sL4MvR/BTAvRKOA+tXuzYG0z+ebl95CMFg16QjL4u4qvfd4AiNJYBPH71wxi01HZv7uAXKKV6Zr2PKSz0tO5HCTCEyRVWpap9MGASzoxHQfydP+705I3MOfVm37lOUJilR4Yl18En7lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E4/Vwn4c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OyZ8vx9v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476ENY9B031228;
	Tue, 6 Aug 2024 15:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=8c8PfscIfJ54aj
	IobcpQFVZEwK4fiPtj9jodts/UWak=; b=E4/Vwn4c9SD2l7q08nfLhHDND7x2vA
	iVRRCl/bxTwSN2/stL61J8FW5JkuwEaBfB6rzzqg358B4l/wmd97G+xUWrwYWjns
	QJIVI083Mhc/7mk9C2/Ito0D8AtCLBVL7lyrIZnlg96l9UuYYff1PM3YfD/WpSCT
	0y/0+qnYRT+mOyxStbQTPP9WRrx2qFXDhdyDYrygALn0kvFbCTXkrwwp+3Tirco+
	HRJGWNYRs8jjHZ7jvflYC/EdIh2ywmMtKQ/VvqDwsGmoQ7QMKc8Pe8jbRWyfv9pZ
	FB8jkJRXya9OlI01k3JJ98I8H43wbRU4OiwEqtkHxrts0DaINBMwZcUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbb2nphu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 15:38:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476EhVkf018280;
	Tue, 6 Aug 2024 15:38:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08u90c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 15:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaFQavIbSVTZSuV6G/yO5xVBsHdqF4ybKwndAAIAKgr5lNRRVgwjEqwBu+/fL+mcrCaEbG/i8T4vQNwLR9+KFqmHTBSLXVtp04PZoHuQc+DFRpLV5rsGQpUF4tXIevGZAtk8zLwJSywBSTFIgHZCWIZtL2Db24vlbjo7EjB5bKD+aT4R8VSXdpjVrOX+NYfZysJP+sAkvCIEb4KUwzEWD/SrT+zE0UzURfqnjvVRDyn9uu5CGE2akKziQby7cYXB4f9Zmdcq3JBg4BcDHmV1P2ZaHoh5FEO2dlg3qHATzedpDSjBEvXj8Hput++MlXOZ+7ozrZiihekHCIkhJpKAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c8PfscIfJ54ajIobcpQFVZEwK4fiPtj9jodts/UWak=;
 b=GCI9n6oR3UwHhmseR6F5o/dsZGfWTivlA2NgPTPDjZhxCsTooS1hxoRTw43ZxXmKcX4Q+XemP88bRMa7m2/dHNpmIzkBFo3R+DcB/KCz6zcSp8eL1zp0ha9dgTCbNx31mFwR5jOAXgzvpxILsESVkPH/1ArAJQ33syl52l3p6TsngSjJqvAWmHiD13/aLLNR+eFsLJyI6Xm02kmd00bBrCoMj3QMggvx+DGhGepKlk0hJZn7wtUqCy1diRuyh+JmbaDxFGGrvluWI5PnvkyMfJaUePu9oOs2iYZcbaNYbqNC6hho7eCCPaw/+jVC1ppPPI+iXWvgtTt+2B01s6lrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c8PfscIfJ54ajIobcpQFVZEwK4fiPtj9jodts/UWak=;
 b=OyZ8vx9v4NyyFiEe3r4dcJHDYQomoKkskcfxfSmuWZHi4JgiSbT7FqCiFIb2QiCyv0/3yIjvimRcr+dL+kah8lXog3loz/E4GJz3XZOvtF5ilVDB3qdAo0u0iF5nC0P28xyhJvLyyCQTouxFMd35KsqgsPinP4kG05TjkgXraeA=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ2PR10MB7081.namprd10.prod.outlook.com (2603:10b6:a03:4d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 15:38:22 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 15:38:22 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-rdma@vger.kernel.org, oberpar@linux.ibm.com,
        chuck.lever@oracle.com, vegard.nossum@oracle.com,
        Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH net-next v2 0/3] selftests: rds selftest
Date: Tue,  6 Aug 2024 08:38:06 -0700
Message-Id: <20240806153809.282716-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::7) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SJ2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 29dfeb10-edd0-47d9-ce72-08dcb62dcd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9h1yDw1sY2CkT9CaeVsMPClKO7xSL6P7W3LeeFeVeeILH3i7H13oeVOTfG79?=
 =?us-ascii?Q?EiVa7cMxTe0JyaBmUw8BszkZD0upP0iakvSAu/3a8F/kptKu2/ev4BfHr9Hd?=
 =?us-ascii?Q?rJrGPctS87B4wa9lVBdH2mBcBRGmSsCch36KqhfQaZEm65oXutJxzOxeAGd3?=
 =?us-ascii?Q?UaumdfaovhefUkqGl0UhnF2I3Ilzcx4LnQZZFOT0+sbsvMUwEE0luGk6uFJv?=
 =?us-ascii?Q?VF7Qx9Dot1Api7871LBgPQuOTqUUd9NMzfEkZLsuSTbQhcPPrpW0f3NlYuwp?=
 =?us-ascii?Q?wrbG+B7hzn5+XNN9Aj84Xiqh3aXjY58hpJgQK7o9WRD+3tEkQ882lm97QmHm?=
 =?us-ascii?Q?dby3FNL4Sw+YdiZ3DB6YGWxBitZYZGu+R3MJVubbEAIrKhW3Q4QrdFmuoRNI?=
 =?us-ascii?Q?fGIgw56TSkcTLKm2DeoLxRK3RX0VfBaFYwRSN4VnX0TiRXEB1NXiM6MRXKKF?=
 =?us-ascii?Q?osiEbWu6oemufAAbt2vErYWorr4DOaL3C0lIit67JC9/owly0n1X44snrHY6?=
 =?us-ascii?Q?9ByODm6sZWQQejCeaCnHS/dHWqukjo5+5KiZoPlbmgKDUb2DS9GhWFUN0+8d?=
 =?us-ascii?Q?LcP1YP34OWNygZ30DcCMibR8KwlhoEJt/cYsNBWcDz5h5dLhJrR+6IMINx+u?=
 =?us-ascii?Q?9WvurKgor9wn55o2U4NLtogyz8RSSusUV09mm0KZcfG5wOU0tTkDgUalV2xb?=
 =?us-ascii?Q?uqw63Oy340V5NnU/8yRx6OwYABljEoTOYNykY0ViIlPxCMXZjf1lXc02HIa0?=
 =?us-ascii?Q?h6fyl+lhnvc4h0APOdWrlkHKEViZvPFynapD93EAGo399s3KgITd56+6JhTg?=
 =?us-ascii?Q?fy4T4aaY78y/D8USAYQCA7FMEV84XYrCDR89+mfHraIcIlVuoehEJE8KATVQ?=
 =?us-ascii?Q?lmzLW5In0tWaae5Zz3hI7E3ajv92YVqxFDfgpGbrZDRlSarlUpO81fUfr0Lf?=
 =?us-ascii?Q?m2v32vf8a+TXIwV1Tmkws/u3A3ey4eTg5WBQDC8HlusB+ohrwDn28fcL0cbJ?=
 =?us-ascii?Q?qSi2YhCOBL/C4RmSdNEcxIEGHM/q7qHDaTR9KMkXh/wpQL1UqvL6InmZw8if?=
 =?us-ascii?Q?66rhdXi8z9JWJ6LBQvRd9XDuATddvuYwxdqSviWSAfdU260R5bDbNlb4DhlF?=
 =?us-ascii?Q?nwa4+BcCpNJ8EWCvq/BfmWwpgVkC4SZAwMimQnUuWsWuAtbDHYk/xRUk98va?=
 =?us-ascii?Q?oM1JXIhqK61poVZgM5johVti2DEcX3500PcVoLKbO1wpEz0T1P22r6sLl202?=
 =?us-ascii?Q?yUH8oZqJ3u1T61qwJobRRTW2VBucCktWBBe0tc4XcEVRSHqLAhdEmOjHIVbh?=
 =?us-ascii?Q?OYc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K6VJfcOOkjIpkqPQ83TV3XYaW1Gv6ZZXrRq6F567jWC+7Qzwe/21Erv4k91P?=
 =?us-ascii?Q?BhRdcTn1P6kc9AqxI/TGOmjLrmkwii8LF2WsI3s9PsJZBfe27Jv74Kahgj3h?=
 =?us-ascii?Q?9iaUqAJNHIrLjPQEblWVy1Y1VVs0tvoaN1cRUtyIjj1Nqs2b/BJWnrkYZ2cu?=
 =?us-ascii?Q?76ZyEucUztaTDr/irNlMpmHyAsQv3jNBgW5Cv2RUbS3h6FWE1Id34O/exYEA?=
 =?us-ascii?Q?4QsoBLABb5ut2lLJXzIaMb02TQEKUwc1MXJTEt1T4wWEudnug9Rc0BbfJuqV?=
 =?us-ascii?Q?P/HHEqodZKGd8m4DlUp24NyobFd+pn2nERX6FWMAUR4oGGuEfcSOl7OMvTHk?=
 =?us-ascii?Q?oozXdFvsmm7JbeB0/SZr98c1psCMzP+YTZAyXopE7p+rYoGbtgZ4q6GRidub?=
 =?us-ascii?Q?Al5cBZvmW/ulNIUAanBjoAPj1/6LKJMUWQWung2L8r9XQk6h+CV9M0XDb8Zl?=
 =?us-ascii?Q?0zXpJo4hUWltRnGYdh/Ndo9PdscqxSf2PFrZ7JHl+aXs4UHJ8on8Ny6Lv+26?=
 =?us-ascii?Q?5l5XcSdwRl47SaFxHVgGal/FISdZhbwGplZ8mvuhVoYpa3fDqOkpO8W7yzJv?=
 =?us-ascii?Q?KvgEOTjpaNcAFWIINDltFh+DqcCmwIhf6Zm0CRcOnoq8Tu9BG/E31zAxh1Bf?=
 =?us-ascii?Q?Kdd6XKhSfMXsZxNvNEUmip6pDribntavaYbGNVx9OuNL65urEGxuu7wDJc0m?=
 =?us-ascii?Q?S3JHeshan7fZhvkm1x3ed6WT796n3BnAZTZT3L6a6LEaqlKnzVJVDVqC4DmS?=
 =?us-ascii?Q?4Nq5+dRWwc/kYcdO8c3CvbLgzKYntSyMHT8fmH6k0NoVXy4eGbXLEOIip/6+?=
 =?us-ascii?Q?1eM2kV8FZp8eqC6H22HlbicuJKG8gAS4+hgA0CDOiYvB2qJ6qXJAOQMd5JU6?=
 =?us-ascii?Q?BX3IqzixjIpDTZwpnF+kBTXRlVyZYtsXLS6SnQqHBvOAsbLr12tvJYk72tMA?=
 =?us-ascii?Q?gop3ycwRDAPVJZOjGXJW3Zem5U54IzjQnHMKi4NWmBc6A9AkArGdsNJY5QDc?=
 =?us-ascii?Q?n60UAxfYfNqZBs+aUz9MqnHIveblYj7PAnYl6DwxfnyaUTzACuv6LRdYWzt7?=
 =?us-ascii?Q?ODxyID3jVOfHGuddLTplYIE9pZSY9UY3rfw4WHJ7C1wItWimtiM73qtzHwLz?=
 =?us-ascii?Q?5G7U5pSl8Ej9mWT84s/NXno07q68vOCypXo87IMww8UcOEVofTM/wtXJqMFA?=
 =?us-ascii?Q?lQpNARmT0pECKtFLBnzYX7DePPbgGJp1BYUJvIY1n9JgBKNmY6ZPA8qgIUNK?=
 =?us-ascii?Q?UTclUGResTtMp/4W/AL1c/ecwk5ua3m7VqijHVDPXbvF4ee12745Hj3opH1V?=
 =?us-ascii?Q?zJ87Onrs/ar0uPgzWBDL32MkXYF8sC4CszbFPl+71mKsV1H7oYj+pNEAYeZr?=
 =?us-ascii?Q?b+XxxKUPvTh995TZDIIxu/lggWomxx9qmq1dUEtBuwCUwH40VQQpaWdFg57m?=
 =?us-ascii?Q?rrTOTzBADK/9QtAgjIJqyBHmiq5Ix3GrBgnnawa5XGn5YzSIvRxUGGnYI2ix?=
 =?us-ascii?Q?FQWqjYW7r6ojOG0Xw/G6xDCaU6JSoLjbp/k9PSX5Fx1g7SWR7g+xfkarU+uK?=
 =?us-ascii?Q?itdvhDIzbrIb9ObjavRu1m0Nb8A18jrOS1CsDWePFebXjILNxuI5YAp8yDp8?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S2ltfytDymSbbqzMZtfB49Cz7Opcx4lUmfvENk/yvDYQ5OGtwfSzhXduW6qFn8RzEIBfPvt6xf+W91W/ZN2ZTffq/RYLR1FyaLsOpvrEfGx+zos8vvIBjKPeTzXwi2+FTUn2q6CI3jw2dZy6mCgVsOfQxu2S+1rC6S2bvFpKZpHk6t1QA8iM3jlzqGAWzoCYntriwM7u9/gWXT6q8VzcSW1WPIM6U78U3A91+AU/NVBEHzv+M4bjgXrd9X9ClJFV9vzB2ZaDxefuJYcDYsxg/1FsEiDIW74JpOO67dT3OLIAW15b5Ml92V7z0h1I4nPlsv6CojkEfRGSGiMgxL+XJQZkkhgVMdtLI/2eaQVxczwsukci0aIyft9aQpgu7YxGEmkp6yq2AV3dfZzmKB31Ekmn5TdcSG0UszQuRni9ggjkl1293UGC8v9P/M6TF1OA0Sm+mmei1BHVSw9CqTOPXMEqmtC5gLp+bT2fSnKj/h4FHRw3ieUbfR2ZTnRUAmgvf+ehpj7KKPzfCTl9/JpRsbkrg2J4J8KsFqcY5BQVw0R4AMpJ4psenPc8LyNDcdmIEimF0bVJIoM5FdBW93Bem//AXn29SKjjhqbJREa7v4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dfeb10-edd0-47d9-ce72-08dcb62dcd86
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 15:38:21.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoMt64a16nPKbS1gIFQYzoOCrqTHt2tX/xyMzkk+Pny1nwtuThFEj5BFDY203aclzKJfWWhoVn3dM2kziLGe8orGSuxTaPcfnjS6djBqJ4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060109
X-Proofpoint-GUID: M-DKu3-ZUh7IAjGxWp7V252gQ62nycme
X-Proofpoint-ORIG-GUID: M-DKu3-ZUh7IAjGxWp7V252gQ62nycme

From: Allison Henderson <allison.henderson@oracle.com>

Hi All,

This series is a new selftest that Vegard, Chuck and myself have been
working on to provide some test coverage for rds.  I've modified the
scripts to include the feedback from the last version, but let me know
if there's anything missed.  Questions and comments appreciated.

Thanks everyone!

Allison

Changes in v2:
- Removed qemu vm creation and related code
- Updated README.txt with examples of running the test with virtme
- Removed init.sh. run.sh now directly calls test.py
- Some clean up done with the return code handling since there is no
  vm between the scripts anymore
- Imported ip python function in
tools/testing/selftests/net/lib/py/utils.py into test.py
- Adapted test.py to use the imported ip function, and removed the
local ip wrapper
- Some line wrap clean up
- Link to v1:
https://lore.kernel.org/netdev/20240626012834.5678-3-allison.henderson@oracle.com/T


Vegard Nossum (3):
  .gitignore: add .gcda files
  net: rds: add option for GCOV profiling
  selftests: rds: add testing infrastructure

 .gitignore                                 |   1 +
 Documentation/dev-tools/gcov.rst           |  11 +
 MAINTAINERS                                |   1 +
 net/rds/Kconfig                            |   9 +
 net/rds/Makefile                           |   5 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/net/rds/Makefile   |  12 +
 tools/testing/selftests/net/rds/README.txt |  41 ++++
 tools/testing/selftests/net/rds/config.sh  |  53 +++++
 tools/testing/selftests/net/rds/run.sh     | 224 ++++++++++++++++++
 tools/testing/selftests/net/rds/test.py    | 262 +++++++++++++++++++++
 11 files changed, 620 insertions(+)
 create mode 100644 tools/testing/selftests/net/rds/Makefile
 create mode 100644 tools/testing/selftests/net/rds/README.txt
 create mode 100755 tools/testing/selftests/net/rds/config.sh
 create mode 100755 tools/testing/selftests/net/rds/run.sh
 create mode 100644 tools/testing/selftests/net/rds/test.py

-- 
2.25.1


