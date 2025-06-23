Return-Path: <linux-kselftest+bounces-35619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B2AE40EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B6D188459C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7F246BAC;
	Mon, 23 Jun 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UEbUBgBO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vAKF3FW8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B2245023;
	Mon, 23 Jun 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682746; cv=fail; b=BP36aIsRL/BnsGx1eHNyNrNlnvYsbA+azgoD3HkFCcskNZWuypfc4SyhX6J+Rgf3PsFH8BYD869/FvbZZpH0viWEmP/mrwdICi+W+ldsvD2M9vlVM4cxMe51y32+xoQUbuwdSzBZcflmNfl5Yna3ixr+tkxqd/rnR3AuuIb5tzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682746; c=relaxed/simple;
	bh=aFABzUDjHbxE1kgiyo014kAvP3cpXOYNc/6ycEln6yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b2qJvIsd9suXyjpv7O7mZQlpIk4yH+IU8hXjgBmMXXRM7+ccvODUAKaOe78bVCrdZCd2mw0Bw0qbb6A6oHNHPiXdtMAqcmxCkO+vLCHgXWjdCEE+vWDS/Y+XZxf31Y/TIzCTMUFLy1Bor/BDV6xByd1UFG0nzdjeaftD0sgbPv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UEbUBgBO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vAKF3FW8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCieGr015654;
	Mon, 23 Jun 2025 12:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aFABzUDjHbxE1kgiyo
	014kAvP3cpXOYNc/6ycEln6yw=; b=UEbUBgBO7t1rcOE+YMMA6drnujHT6oyBn9
	1vLqKf1Ot1pdBX7hotLbypqJBOwWvcg86DMCyIE+bvMjDGXO8YklxkoLo7sIct5K
	DPEM4ZBf4RhXlzrAlMBbDkB4slibfen6td5DuGHSkGoM5nFZVW9DZC5wjZ+3gImf
	ihIcVDOwmyPgSuCVQ5BvhlLsK5LmIi/lg45ZnBSFOKYFmLM3qM+1FJWt4YAuPPAB
	bL4mMVu1l1wEtvUEl1CuqJZc7tnncBV72tNsB3hARm0emjGiP8n4AVOmupLF5kVZ
	QOQflB4Eb2iGX+simnw/PmlgFGi0Tmpeo8SSI8OgFE+gyOgcWHLg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt19gk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 12:45:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBZmld024179;
	Mon, 23 Jun 2025 12:45:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkp9r4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 12:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8snVz8fhazIa38MVGwYoajlFkUXCGnsbwpFfqRrRHr9KTri2pQRklHQ2u3kA3uCTDf2mTGciiFO9lXcQB4GXg4n8ewRvqlbnWOJOVySQh9YpZEYmRxIt8D/laYO6ErGIOLOm24sXY+QlkYOMCaAhEXlgzO4pEzZc1GNTC7+40dUS8GGKsndk6XYJGoRuMqTYddyHicmhg8HwEyzXQqmnGH/UtH6isFOuh1/4wWu5iYttYNYTH+08+VHtke+XV8WZIz/F3Zq/F6VlpSHnzHLKVsS3EHy958LSQrrHknaIEXI8jtoBaS0oU4KlVJc9XeGVVOiGsjmfT6hLslZhdNp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFABzUDjHbxE1kgiyo014kAvP3cpXOYNc/6ycEln6yw=;
 b=wQ77fyMlh44JYZNnHDmPFt9yRrp602dOUGtjkVB0Iq3CddE5iH3zozm4f047rViOHcA/C7NYUnJV42amxIZ4V9Nz0OP98Qt3p5lHWncp8YzIM3XP2RM7lkciaqH8tbBoRxg4uWVEuay4bSTnBgnlY1h187Ok9K+7KXRvwbsuA/fipBHVOT8xk5AsAPUGTbT8QHFlTqjqdTF8ptrewEzsXZ5T5oYgzOl1Lp6MYPZ4Bp4PyXt+1is5619Sh2t8pwoD6MTiVbWSQEqXS0VcuMNq8+wJ3oZPFNH3SM6c393g7JnjXsyXsBUv7dFEIojm6WIUBkZUyZVwI+Fu6vPtFo25zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFABzUDjHbxE1kgiyo014kAvP3cpXOYNc/6ycEln6yw=;
 b=vAKF3FW8BjHGoUdNUo5jdDD76LxtT0NPJZQoK7GaGLn5tEwOhvbrDI1cqV+15f1maqpVSjZTPdK7/JRRqarajHDsKvQBdiosB1DJxLbfxEvYTxN6+6lPGzdFFUuE2k1lKhEYp4AZY85CaAYoZreQXkJKTifuj8ZqKPxsPABpiV8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8395.namprd10.prod.outlook.com (2603:10b6:208:57f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 12:45:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:45:25 +0000
Date: Mon, 23 Jun 2025 13:45:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        zijing.zhang@proton.me, ryncsn@gmail.com, gkwang@linx-info.com
Subject: Re: Subject: [PATCH] selftests/mm: add test for
 (BATCH_PROCESS)MADV_DONTNEED
Message-ID: <2c6282b1-af05-46a4-b656-bd7be1948cd5@lucifer.local>
References: <CAD1ZK4avRrfjkS61i089L2=_v-GzerdYOR3GccFFb0q8N=Yqng@mail.gmail.com>
 <8c6a25de-be2d-4ed7-a59c-06f1737102aa@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6a25de-be2d-4ed7-a59c-06f1737102aa@arm.com>
X-ClientProxiedBy: LO4P123CA0692.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b66da78-d172-42e8-5763-08ddb253d382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BO1G73YAuiB/3MB5CCV8Y2i3CGl+2ipxTzU0Ar5OLZpCVBON1PncOdJV8TYU?=
 =?us-ascii?Q?NXffiOW4j2Ou2A1HpVQXVgk2jVvia4Fl9XmOwWF5bMf4Erm1Wi9H2G5s0FEI?=
 =?us-ascii?Q?OwoHYhV6PGygXR3HEZkGoi4j0Fgge3gvxZaK/WC8pHlVpdLFj80Sa1N8kfhH?=
 =?us-ascii?Q?x9mw/3gxeWbAvbfkMYspWPS/3m9NF3FIYnyQxuGBB+zMEPzm/duIRR3ExCQ0?=
 =?us-ascii?Q?1uKH2UxPRHMyRPP442EYDX2tmM0/hy7wY1VBtwDc0xByRLjulJweWFO3IJfZ?=
 =?us-ascii?Q?j8jyrE/y6phzW9IdiGnSLs1J+m5JimRBaEF6jNRdRREiFKLBYw6mL/BRkX0h?=
 =?us-ascii?Q?t4Fg4ij1TIU5kQmfi2M5Cy7y1QtkY1Lr8DexsEN0WiLo0juJqi6sPNmscoei?=
 =?us-ascii?Q?97y+Ib2cAwcMO+R25kroWLCwqMCThrMQwakzosucym54PQQ0ajSOGVbnCDcj?=
 =?us-ascii?Q?4ajvj0w8AeLIeXAv5wudDe7nIN/dg88w3NA0LMz7sdq9uuAJjbdSraFZ8yx8?=
 =?us-ascii?Q?Sq60N5fnll8U6478V3IDAfm/qbkEgHtLt+7pZ51Ed7WXpj+xwG1HBvFJxefy?=
 =?us-ascii?Q?jmUrOiHXkA3VNh9IA92npPAGxR3WjYBuiOZpe0S2trl0NluCLeqzxwiBJDia?=
 =?us-ascii?Q?VcbKUgxrgj3dsGlF5fklDySjQolKG6qaUMK6gki7dSeeYD7IntmLntEx8VOr?=
 =?us-ascii?Q?/g/w4/fEx3YSEfPDaNhsNDWS8dDLbdNU2qzOIcVFVQEOKvgnbEt7/pzwSrT5?=
 =?us-ascii?Q?gffl1LxRB7pTJ6yXlTaDus0/0yrWjkO7URTBJnw/r+IT0dKPkrK/jOiLrwir?=
 =?us-ascii?Q?v9UOHWwgNy/7wU8ykUE11RT1ccRE0fHNzM2lWfwXix23ErA5TmN/Lv24MhIB?=
 =?us-ascii?Q?veSBjegd62fmWc/C13b+677GD9h3Ty0V2I48grkPZRMAsa8UKOFKovbqO9L3?=
 =?us-ascii?Q?oLdryeXh5qDegSuL9Sex8yW98Jwve2cj6QrhzxSDZ2sVP1XyrMSXHF4SIRCn?=
 =?us-ascii?Q?PuwVBoch7aHu/P6lpg5vd2GxkbyDzeTtJhioTwR0NNZB838d1DMvZ/3TpOoF?=
 =?us-ascii?Q?nCQaf7G4uPL6dXqnKcTCxBCnQ51Q401PvrI/39v/d9oC6gfX43tYX/GBvCbC?=
 =?us-ascii?Q?PnNwDZ2z0CMX55/9PlicTg8/pPxKdNpH6/IiLb3tbp1OuNS4v5NvKOaB1mo4?=
 =?us-ascii?Q?RQRgGUtBghB3ou9CELM3U0lFR2o++XB+Mok53HCTKoI70oBypyXJ9i3RZrBm?=
 =?us-ascii?Q?Agu2jYg0NKbDFnh5h3/fEBYahruDAuY1ITRXM17Kmuac+Yt8bUOpk94Q+v5X?=
 =?us-ascii?Q?4qDT3d7p8WKfA8dtM66Qdl/n09AiaJZ40fNb9eS8AHsTFyK/e+wAc62yX01A?=
 =?us-ascii?Q?mqMq/XJGdH9qxvVWLJbhB2UmXIvly/DkiEnDOOpUDQ2Izs++GJCxWBK27wSw?=
 =?us-ascii?Q?CAs+bUQ7Xcc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cs3BhZaXR0Eow12QECT83VeFt14Uxy3YmqBsbv71nL7YqDqTne1q6QYk6lUO?=
 =?us-ascii?Q?VlrbDnvUzXowIHIdtNCMYG5A+kNCW+M2sskIzhA3077+T5xV5+VInNQUoq8K?=
 =?us-ascii?Q?nxGh9l+Q6bYwEdeY5y7UX3saVFG3UN7j4m/UfjtHmX4/b2Ch46pnoZZZGCFh?=
 =?us-ascii?Q?fZjs3ouAgdXG4yNMKb4M8Km3iO94wNeWZdWJZZKZCO2v+2wMr/fw0zsY5iov?=
 =?us-ascii?Q?LnqAyXD43IuEBEAfqPcMoppy3MxJSEU57BXdmfgwBu0EzeWJPM6DAHGcupgD?=
 =?us-ascii?Q?QYRDNshrFfS8UYeLwyowt78p0wdSGr4YBTAF6yv6rSpCdIeLDIsOFIBstN1x?=
 =?us-ascii?Q?sQH8jHxOy8TbPWyscb+kXQkq2DHDq69U2D+drbCdt8PDoJIFQK5XBNgjZXCo?=
 =?us-ascii?Q?eb0OQ3vJm7XjzvuTzkgQvE9N4xSlMRPqUteJBD1v7MHf2eHT8HLP8dpLOc+m?=
 =?us-ascii?Q?8Zb1lAWq+yywUEZSfDOI11q51/X5gTTz3CQ/4TxzsItqcIlq+1QzrgoCskAs?=
 =?us-ascii?Q?NKqx67RJAPJGF0YGDkP/mt0p8aq8cM1Xw9/I3+6YcoqRZ7nDqy5vsafCn6ow?=
 =?us-ascii?Q?hnjwlagWjiVWyM2/mvn5fU3NGanIP/YFUmnLu6cPhEzNTxRIA+BKFe/mep2O?=
 =?us-ascii?Q?IUF8irpIAJ2VDQ4jK69fNiONNFSuctnhhJKeFJDEt8aXIuwuml9PirTQISi7?=
 =?us-ascii?Q?JL+4FCmCWI++4LAKLPO9OJsL8W8BzWKKaHkDtJSjyz9gKSJHW9PBRYuIHdlm?=
 =?us-ascii?Q?f/0lpZXsyd4hBkhou7utW2pBIA3/nsiY8w/Uy3cbR0mtkqXE8baOu5EdbefR?=
 =?us-ascii?Q?R3fi13mvad+aM6bTW3EagcjVwxB0zk4Lq/RaLADl/VEMF30e+Gmd7ouoKnQU?=
 =?us-ascii?Q?XClHnbV8LB1rcM7k/FITHAwQh8qo6+8aXKbP0qRcE9Wl0KELRNqFLPj+V4eS?=
 =?us-ascii?Q?PIIUePKopZtK2/vEJUL+DQkjYfufOcZQ9ffXkhBnNydI8Yyrb3SH4ZjIQhzG?=
 =?us-ascii?Q?8uXE3Mb8aBaJp07GeENOTolS7AKEdkmASSKfvsnmjb6//uaRF4A3XeqH8KUz?=
 =?us-ascii?Q?zndd/1uMgPhuVM3KdUFqZPZGdkJ+zHHJuqQTvKZOQ+c3wKUrOxXUXRFVFrnX?=
 =?us-ascii?Q?FRdsCadVqZk1DoYgEKbwWnk5SbypGGkQxMN5aQhI6+6SwWa3dmS9eemL2HFt?=
 =?us-ascii?Q?PJh4vKCDR80Dm2RYBXU4+B4OWWTOEJWf7vdojwtSkc9TjyOznLeRy8z2QSO7?=
 =?us-ascii?Q?iadjumGvsRrMMSd0ymOK53Jc3/AS9aUBi+1ecg9jeQLx8GZPewPHgSZcg1dz?=
 =?us-ascii?Q?lJJ5hpeziOY9CfU0pPdpcEVSKyrnVKXv++0QVzI43QJXiMe3NaAhCUb14SoT?=
 =?us-ascii?Q?z3PpsLo5DrvXIj+/NUbastzc2DyUF9dSOwPFcIBv8rNqnJeLKuMdCQ6WA4AL?=
 =?us-ascii?Q?Ua52WvEDSoB4E5xSYSZdtz2IomMfOd2dJWndkDxroqQ+27opcambpEt+Zjrl?=
 =?us-ascii?Q?R1jRdMksY5I1yHiaFMQd50ejlf+3zfUri+4g1j2iEzfWk/B5IWwTZFx/C5V4?=
 =?us-ascii?Q?y658ZXCKueAJV2Bbon8GijFucmq+PKxHRsegFVHF49siDCCAhgF9fbErzESW?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1cXTY2F8/zJ/ukDmDfLUV+QLAgt3Jah1Cm6yTE9zMgpoM47j7hq7U2MeUFUPRnjpx8SYpAnhJ3DWT+ozDMeQpTqGhPF9RDyagVdC9xs2YLaOjr9xUCnBx/ffdnNnetVF8zWXegcT9Xd1f2lZCKgpKUBw/zy4X056xigHvifr/9kiYh1E7O1gD1wFbTFBZPZzID9n3A+Mf2SL3L8ft+5miXiU4RxJSrDLYQR5OCQDUQQICkwHW7htTPxjWmcDnbn3yT0X+mY4V5xZgiZoIrZTkayg1DY8edL/uAYNh9rLt7HO1/oU5539qMEMlMdOeaO18315InCSn/5iDJw6TPvmrjSV8n35mIA58LKJACrORnk0bA6hNje2z5RQacbRrVITSBRuRgMOJRet9whDnshhJIGkGX7kz5COjkV5lIegBSeZox51sJvkmmVF/mcLOXWg78FuUFhQygy6H7O8WyVI5qdXmLLtS+dZOUX4Ag2kKSnfjJQ9yhpc874SVXtp6BOkLiPJ9HhfZwGwesK7Nub58JRl87lltJGoy1zPni903fOmQjAV/FzAOe1HmX4DpHZAmTZGd91nqbZ/XjG3Ed5keGe/M+28RvfaYBLC3zjwrTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b66da78-d172-42e8-5763-08ddb253d382
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:45:25.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMfboivZ++MC86FUxy672aUNxbUv95ubvfY5A06aA8HVvi6wWMnZmT+kxeLwHCtLER9+qyQFOnY9dMGVFKBp17pFhFAhXfhfqXNcSIeD8iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230075
X-Proofpoint-GUID: bZZi_eWrk8WaF1tbNgpUIkxQ_TbijKCU
X-Proofpoint-ORIG-GUID: bZZi_eWrk8WaF1tbNgpUIkxQ_TbijKCU
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=68594c69 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=VJa72CN7aD8DOrB0xHsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NiBTYWx0ZWRfX714vpBJizDSY y6FCHRsCFd4YEFn9SrDIT7OuxGRz0IZU2fQ8+dPrrLLcofn+05a11HqcnjuBF5lZFt0syENAIFi AJI83edcW1VJclZ1WsO0mwNCZLrhQ/PUrUqlrA1ul8vMuoGmSKp0pQvEYIaHn+1BzXCbrcOaHTk
 mqKCK4e0TkSVgxy2OkBLLVOFoZMmEf96cJydoCefMyEYjd5dHGYjWlwpxOBdlWXA1H5PvGie8Dw ue0mLSlPQsbMX5ilLR70P9tLeWkswddvAnDNev8D2jGURqG0JGvbF5IFgQnGjDRQovWRinjUV30 0iq80tMe4cUiAGoJCMnv6uvMjLQmR0zbSc9EKw8SsqqriyMz20y+6czThRHLC5iIsvBRa7uWCED
 xSSyZu0rMVT6fo4vdI3bFuAJh+CTmCehgvT3N+LUiC/Qzz5qRTB4spqLw4BVHZU9RJX4QP+g

On Sat, Jun 21, 2025 at 05:08:18PM +0530, Dev Jain wrote:
>
> On 21/06/25 4:40 pm, wang lian wrote:
> > From cb505647eb5f418d1ff5e807361f4c3a337c251f Mon Sep 17 00:00:00 2001
> > From: Lian Wang <lianux.mm@gmail.com>
> > Date: Sat, 21 Jun 2025 18:51:49 +0800
> > Subject: [PATCH] selftests/mm: add test for (BATCH_PROCESS)MADV_DONTNEED
> >
> > Let's add a simple test for MADV_DONTNEED and PROCESS_MADV_DONTNEED,
> > and inspired by SeongJae Park's test at GitHub[1] add batch test
> > for PROCESS_MADV_DONTNEED,but for now it influence by workload and
> > need add some race conditions test.We can add it later.
> >
> > Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> > References
> > ==========
> >
> > [1] https://github.com/sjp38/eval_proc_madvise
> >
> >
>
> Hello Lian,
>
>
> Thank you for your patch. Please configure your editor to take a TAB as 8
> spaces. And,
>
> your email client to sending plain text messages instead of HTML. Please
> resend the
>
> patch after making these changes.

Thanks for resending this, but please do put '[RESEND PATCH]' rather than
'[PATCH]' so we can differentiate!

Have reviewed the resent version.

Cheers, Lorenzo

