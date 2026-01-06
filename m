Return-Path: <linux-kselftest+bounces-48307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7CECF9322
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 16:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD6130783FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C04734CFB9;
	Tue,  6 Jan 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kpGgco4w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KxJcCq2r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B731253950;
	Tue,  6 Jan 2026 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714382; cv=fail; b=g+f/YtsQOGYEtlB3Dq6xfuvh5rwJCZn3LjTvG+rS5eTsfozhuael4df9//lZ6msndqpnTAJHNFoZHda4SODPCrGm3/1BzyxZ8lqMtqd6IeMPl9iXXcwWEJnBxA+idZFKGW9lsQcRCiLmY5M3WeTMLX49Knv6O60nqt7o850Uwrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714382; c=relaxed/simple;
	bh=bzil+g51BIT70jXE8YtFVocT2H9UteprjM2Y0fcCv/4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O7EW4emrLmTh29jVJ5ZxjDZ3P++cwdgn5seJD6xZbXNM9mKmg0lVvOn/Avqy6CWeRVZSKa4p+40PVHRzHCWz+t/VuAVd15fIUlSBD44OGsDo/ogGDSK+GaUAtI44hRXfJjQKr6a4fSiT933mynQBsgzl2Pw/luTPMnCk4jJJCu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kpGgco4w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KxJcCq2r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606FeeVl4161806;
	Tue, 6 Jan 2026 15:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=7ou4lR10jUDoCEp6
	EInbf3HSC4pDpbJMJz91KwZ8IZw=; b=kpGgco4w2MSrdLOkiJVPf3NZrodlob+A
	nPONEA7b+U4M15QnubZ+TTeEoU22Iq93WlXhola3DK7yP1of+xnnkk5aRFk0rV6p
	ONAH8h3lGWIdB0Rzd7Hx+FU7UCR7udwVfznWFhB8RGU1o9QkZI9Kx2Mwa7H4fM7/
	rXMvQu8UT/9YyHZxHPcuE5R1BPtU257xdI70jd0Hyj0wyWHS4Uzd5cRYVdgeSVJo
	iJp9XkrLU6DNSel8gYPx312TMRz8rsovv32MOhdtZKM25biyZMwfPX2+TWMSTj+4
	reye6EilKxQCtC7i6U8SaiRafxN80EQbc9vkrhCrh2zgQiGkPzxKhA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh58bg0a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 15:46:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606FgPPH034090;
	Tue, 6 Jan 2026 15:46:05 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj8qxxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 15:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhHQIbT3LRBEWM21NF3IKn9DF4sE1hrTlUI+NAg5PfEMCzWKuMS+peeAFyMQqmSr+CQgqjqdzMUousbXZv2MNiV9otRfNR64gmp2TJkW36MVHa57CAF5J1mB/IpG3Y2gUl+Yy7BJXDPr/+ID+DWY1pIhbciXhThomUm+t9WooB92ETcBOYvYW9oaTTzFemtbH6en9sTsS30vCPwgZWPeZ4PkA8RQ37T3I9n/G80bTKaSbJIzcGon2Po65KeJOOvc/qm5zpCogt091Q3Q8zaEBGRQr4AVm3Xx4cDSjkE5dqxXk09V6juB6129RnFMu9X5au+hwKepdM4uaB6eePy7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ou4lR10jUDoCEp6EInbf3HSC4pDpbJMJz91KwZ8IZw=;
 b=o4xYBUhm2xeAmAb4GilLcXlSQiTT752EWCmmhDz3jeQXWolgKZkh7SwgKxQ7peCr7oXfT4rbEhq9yAr1Cxw2KdiD770/JJbDCkhi0JC/loWaZ6kwh0Zxt2uPxU9sAm50szWAbrGUUNmfPGo5MgvYDRz7PIRYIjxi2ALLc8vWLyGjJLOse7F+6X2DIfnjBAId03ocLa03gONHVSyhZfPhK2iyjik+EEaUSXJm6xlgS/JnVlQbjarUL6SiMkYz4Kk3UU74zYCqDaoKWM54X5hRfYLu61QsFSlNlm4XEWyFApUgCaWFNCQ/3Fv8CTWY8+j9na3vt4ytrnHJzuPHnGFkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ou4lR10jUDoCEp6EInbf3HSC4pDpbJMJz91KwZ8IZw=;
 b=KxJcCq2rVn5F+cyvSJsp9VmVIofNUSvBz8Y8hXoM5/fNOyHndHLhA69VaJS696QgcOwAVE11Y4+/Iluy8gFLEWSIV6NGMyQJbB48YpOySuKdVFka2boTOOA5eaDPMN1G1VMsUxK62GeMZVhWAxPWoHbo5fpsMUHId6DcHALEpH8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4827.namprd10.prod.outlook.com (2603:10b6:610:df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 15:45:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 15:45:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, David Hildenbrand <david@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/testing/selftests: fix gup_longterm for unknown fs
Date: Tue,  6 Jan 2026 15:45:47 +0000
Message-ID: <20260106154547.214907-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: 6279512f-fc32-41d3-b130-08de4d3aaf7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?92qJsHrOEFchtCiQdPvqn5V9tUpBTI0ByYt7MHtacEJz/q1YvkhucopI5vi6?=
 =?us-ascii?Q?75LGqLYuJNcyWTg57/h2i/A5bYq6sKFNJDIst4PztTY22vT5rKDD1stilW+l?=
 =?us-ascii?Q?wjegS6wrlJUCXOsWfKHYX3PbZE8nl0oB8myytzh2CBwNQ3PZs0P4psctRvYN?=
 =?us-ascii?Q?9U3FxaCHtf4VYJaw5McQ8HQmqb9fLYO8vbagoM6Gm68WIUXcy+ZgleQwlOqZ?=
 =?us-ascii?Q?HwhlYUGS7zhrZbZEiMGk9jmwIL/66PqEPBIGFu/Qpspj4ogJy0cV+tVBb3Ie?=
 =?us-ascii?Q?KQWxNDNextbq0rm9l4SX9AyRl9Wp5xJW6rc9qr9gv9wIiRVEcvzhX13B5W0K?=
 =?us-ascii?Q?IuSJrkEhu3B7uWfzqa60UJVu7zhqdXqDfykyzQ0LgdS/H63ObHIpqTD6hGy1?=
 =?us-ascii?Q?PS8jpFmVzjsTGP8Fo49Tblc0OlUrkVCwdI/6mzDaJzv17uKTYJdFsUkfOCHK?=
 =?us-ascii?Q?1G/YuM5KHBbI0g6g1VA7SatmLaJot5oOEbPMUNGhaDHDmtNrOJATqWR5kZLo?=
 =?us-ascii?Q?5klTOmROBBb4QiNodWfK90nhxcSvK1yPhMioFdAcTja2qCZ9xmAMCJoNK4w0?=
 =?us-ascii?Q?Q9VMlhlXBTTbe8LI+VlVyoSVZrvr78cgWaU4I9DRY75g62X588E3ebkR61DQ?=
 =?us-ascii?Q?VxqjoEJoLFKB8n6Gxn9gcZ60k8RC6ek+timo7kItZ5M6EG35loh48d/2qgnS?=
 =?us-ascii?Q?nsniNYbIm5F0yxqrRi2B6gvLBc118+M+cliVqAi7npDxM5Fa+9SgSzlaOBBe?=
 =?us-ascii?Q?tEJI7kEAjEt3C6XnmvDz62DRFQBs3xz8ocb3TGfW15oQHYo4V6ABY/U9V3TZ?=
 =?us-ascii?Q?rnbFLk1KJTXoDpl1GCrrsKyLljeTozvetJXbECRKTaRH7oeZjV4UADJiJ+YE?=
 =?us-ascii?Q?C002SIza0jtGU6/fNMow6tUoKMgULa8OgTFfUvnLuVbFklADKrisDIkd/LKO?=
 =?us-ascii?Q?foJ4aMCw9nevv+dZAlzR2UQpg/5Jx7xt1v74QWBXaLvgbkXYFol27EWST/Fe?=
 =?us-ascii?Q?gfrzZuAkEWz3KtFix4WZo7s4U/yT6dozxEw/OvoV5FZMpBCklTamgeuGpJIA?=
 =?us-ascii?Q?YAAMzMpRJZSc+gD+pTKf3sEj82lFsZVQ2JuaeIZAnTosiUML8ZR4aAdqKtWp?=
 =?us-ascii?Q?noV8zlEYHwOaq3DrU4LX+Az4Ske6/hymbzBgvyNMuxGwTygPJcxp83QCpvCm?=
 =?us-ascii?Q?3QrZHmV90yvjjOHk0dwRRQutsg9IrRCcwIg6+ciIDgEv2Biha1zm3dCJJfgY?=
 =?us-ascii?Q?OuughJmw1gDdsV2f1qJPhE4IxWmgXe9IdIXCSFmo0Jbni0MIIgx9ZtubuarU?=
 =?us-ascii?Q?798eQdgibg0C0t1Xm5KXaZ8U32ehqgu5lJMvleVS2ic+n1hZUbLNafRrPLCm?=
 =?us-ascii?Q?KFsu2Zqz4FPZmFjyLtABF55hF3yqOpXiU5Oi/U1mXIDz03mMjlaAlsRty52L?=
 =?us-ascii?Q?a9abFJvsiuabKGMoFY/AFSK9BLN4FbzI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IWQcDufG7g3cFPZgoVuoqXalWC89ZW7JOSjVTjmxZdgn5s2sEFYh5A/S7B7o?=
 =?us-ascii?Q?yDjo1Jc+WF9A6+pVZqmFl22w9cczoii4hsZmODeaATFoZEQmHRpXgxM7OOVv?=
 =?us-ascii?Q?qeq4s1YzwgFvxaopmEzHSh5m3TCg/KHkTbCYW5UEB9DC4FZo6MaUPpaodXtD?=
 =?us-ascii?Q?m1LQEy4TIj0H+OpMOaK8Af1QAtlQ6gKxvNeBX2sXvD2kq02SctzAPDX4yQ57?=
 =?us-ascii?Q?Pmyb2m+YrqljrmI3jfgf3aTG2x5DlrVvdKuPMU7gZzrmxscBGOtenckToLMW?=
 =?us-ascii?Q?2137fJsy3LAiUjdAxlmvwjiF7TN/iHWJc5ZykYVjGe0UW6f3J0IHMNEWQ4KU?=
 =?us-ascii?Q?SaqlILMtu3sdUy9yxc1SxOkQCbK9tWdmMFMxg8+TNLlY7OJA6fo5K+dqxAeU?=
 =?us-ascii?Q?sd+9stdI3vYh/gBduqw1DDK0+TrWBdaEx1u1ZaIXzTcqrpk0iaLdbxZS6C/3?=
 =?us-ascii?Q?8Pb8lPN2dpeQEhZkMwEH4QP8+7zHBXFKT2Rvv+HoZwZpZBztGzCjMd5E0PV1?=
 =?us-ascii?Q?AT6whxzlNWNN8lbiSypKeolDMNUepBwqlQf9mvtO4VCVzQQbTtg39KoJKA+z?=
 =?us-ascii?Q?0k6zBBpzVU19d4+LOvg4RoKDmGKLONu305U+ngdQbfoNQcBp54RluL56QgcL?=
 =?us-ascii?Q?s1vJQcCyjmUMRGwAKpFdhHLMtwkm3+4RxiwMFJWshUfyMPztCSoDUez8vAjd?=
 =?us-ascii?Q?QNwzpHHtmATApdbdhMreG9QRDTNk9/8ZFN+qfCSUn0A+Yf9ogu3YeLL7JNkQ?=
 =?us-ascii?Q?fVWoQqXKdvawzmPrb6+vzelUDYa1ZsFJ08V0QoaPNQrBljoI572T7jsc+AJb?=
 =?us-ascii?Q?m3kJz/zKkNBP8N/tjEsD458v9hMY5Szeu8VI/uH8TCEhl6sTiucQigOBJW9I?=
 =?us-ascii?Q?xq3jeYfE65T7vNdDvasqo3UI4mJ2agJw0L3B8ds0qevcCpW9+u7FZF7txc6s?=
 =?us-ascii?Q?dWXDKpK5wYnnqTfcdP4DOn8fgN5CkkY/+zJLynZJhMf1qPilyWSx4yv08jjU?=
 =?us-ascii?Q?F+EPNiYN6YrVj7nWjtEdMnds9SqiZa2RXkRTYIxlETvYPSQuySuqaPj0JG3P?=
 =?us-ascii?Q?p9t1CbnMJet1nL/xWaHO2536xUTepYnKUwJy6hBtSMB8AKGFl20pkSZ2pbbQ?=
 =?us-ascii?Q?I+z/UsX3t9x5BYmiOI04l1IJk8tKtKaPO4jSDTrfSPPjt31/2EAu+PqeHjGK?=
 =?us-ascii?Q?3uixbOGhGdU3K/ZrfKOKeyuxZLjhykwf7OztrXroB7nw7cejc6Y/cQj3AL1f?=
 =?us-ascii?Q?Hs865GlSzxvHWK0/rgnNGyh352j47TMqciayHkLUPGw95nhoKzUTlv0q3vmU?=
 =?us-ascii?Q?TdXL+25o/MMCDJdb/mdCTIqqzuNCKrEBKTskjyrQYhHeE+EJPCEDC00lHif/?=
 =?us-ascii?Q?tnHzch4wmmVQBbSnZF39QV+AemnzVVuRfrrV0kWHA1Dy0nkS0pyMkyazatBn?=
 =?us-ascii?Q?CSTBKRGXM9JL7VEBoHcHuhbNgW4cHBosI8yufQvxC90N1dX4Z+3UOG4zNNYq?=
 =?us-ascii?Q?K6ml517aX9QOlHvCcywZH+Xnna3uMyKwzTbKVL+0aG1OBfxGvHzDN0UO7T9I?=
 =?us-ascii?Q?vI/XyEEi3JeH9Hh1lf4C1cuqLLcOk0BZ4HIEK1iNypsrrkaxN6mUoKRudloh?=
 =?us-ascii?Q?CRkC2mDWZytgBPLlfPfti8y+S7Z4Rk8bpvkA2Wh93nhzp5+xskVmNeX42aeL?=
 =?us-ascii?Q?Q+30BlgcHxWb9Y6aTzfjiDXdY0iJoNQuWhsngFevNJGks9EPPwH+0CgAy4Io?=
 =?us-ascii?Q?y37sLQ7CUPmzsSt1zekRBetb99TCtFw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+zB3ZaTt/CZEyqNmgsTCxhJpYsPI9S+V5QJfcD+gqM4brXcwwzwOKhGIUacrZiuuoyRUwI03z6YQiS38H1W9Fb+PSkNS9IsvTV6nIaBlAY3K9ai2Llwv3eeB50HrC90cloa+snoEhwxqs3j87yZvoAGoM1E67hhMoto4k3VzaXK1VwP+Hv/OnpRorPdAoK4TGzoU8BKwCj3v034Ez2vaLihvgbuEGnhFneuBtphrBZ5w63nyLWa4K1LdM5sy8mLSXe2j/956vKtQV6sbY2/OEDV7r7is8VkT52XGDdSPlotlpCxXPPcFnQXz9yoSx93FewUXaKB7QOuKaRutrPWV2dmdRqtMULrmXqG7uGBoNzhBIYxxqE/VpAP9sxANVt3jPxjdmcahX4En2WjnvI8t4l5DymYfC5wDPXx3c+AT+D5le0n2zDdaewc6fDw6lRmS4TF/+foTjDK+Djwu8Olc+qvRafIPX1lXH5cZ7nDF65WVyv5zxUgovv1zirbOqU8IgzEL+LEXl14eJhonns8K80I1UerabRCkRB9lrS4qEe63YYiH3xz43VCF+IHLgrSlQfoM3EyQItU+VpkgJTgVB1l/E5Uebd5IrvD4wqgMmdk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6279512f-fc32-41d3-b130-08de4d3aaf7f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:45:58.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAcVVm5DPOMsnRlThtggKcDLUHeL75okU+9UdIIKRfSwJMTYU/AkXRmYcfioRHNIOfa7QQfZw26o9BFFLDQQln0TApJ1ZAJik792p6IvEAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601060137
X-Proofpoint-GUID: XnT4cxHXziuOcB2njbKsaMsZnn-SFSfq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNyBTYWx0ZWRfX6aGCoaIacbh4
 ftRJiyH8qVpFwS7HyM4i9/+pSYf18SgfMNTUrMEuKiSSgWE7vGdV15KoEbOeo1jgE8zkmV2gFtA
 wVZR+Hm0o25zElXhJ7TUtMksttP6QClUkjEU1zow/3GKgRcDd/JP58pbkuN65f9rnmoF4TesNLV
 TbpY5Aa/+DjA9A9Ad0LEXw8/NCsR8mTtRR3SaUaHiwOL+Dk/NqkHoZ+/WDjowIbTfl4pAPhhgP8
 K9b7p9vp2q8Guxe6tPLKOwyDhkRDWEEZOmAac4n86JnthXu0Z+gnM4v3osqhaYJPKXlZpbVnZ3U
 cJDelW7Jo4CkkSu3e99CVlNokvFfBK+f9MGwGuLiOAZp6Oc6yzhLr1A7P9jeJGBaB+S9k/nkx03
 M0z9Vh6na+DagID83YLpMbWJ8rMX8LnTX5uROLwa/KOWWI5bpEeUP/9dQChVQ7pnpspacvofKop
 riJKkwFX/8SycrvbZIg==
X-Proofpoint-ORIG-GUID: XnT4cxHXziuOcB2njbKsaMsZnn-SFSfq
X-Authority-Analysis: v=2.4 cv=OK8qHCaB c=1 sm=1 tr=0 ts=695d2e3e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=XrceoWfiemwgOeEWAqoA:9

Commit 66bce7afbaca ("selftests/mm: fix test result reporting in
gup_longterm") introduced a small bug causing unknown filesystems to always
result in a test failure.

This is because do_test() was updated to use a common reporting path, but
this case appears to have been missed.

This is problematic for e.g. virtme-ng which uses an overlayfs file system,
causing gup_longterm to appear to fail each time due to a test count
mismatch:

	# Planned tests != run tests (50 != 46)
	# Totals: pass:24 fail:0 xfail:0 xpass:0 skip:22 error:0

The fix is to simply change the return into a break.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Fixes: 66bce7afbaca ("selftests/mm: fix test result reporting in gup_longterm")
---
 tools/testing/selftests/mm/gup_longterm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 6279893a0adc..f61150d28eb2 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -179,7 +179,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		if (rw && shared && fs_is_unknown(fs_type)) {
 			ksft_print_msg("Unknown filesystem\n");
 			result = KSFT_SKIP;
-			return;
+			break;
 		}
 		/*
 		 * R/O pinning or pinning in a private mapping is always
--
2.52.0

