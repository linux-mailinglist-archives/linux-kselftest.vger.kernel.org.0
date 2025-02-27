Return-Path: <linux-kselftest+bounces-27819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063CBA48CD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 00:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006B616BCBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC2276D1F;
	Thu, 27 Feb 2025 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XlAwjPyU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kjJauOtt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5609276D15;
	Thu, 27 Feb 2025 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699279; cv=fail; b=lRA+06AFoMzSQ2fhCpt9f7ihBxai7Y2qQb2SWbPN7g0MuJfHMOLLPG0L9TMGusRnbZa3ge36Qc/ziwmkHGx1MPeAPkyhp0gNP3Hxv1wyC9w0y7xSkpafqn++nxRHMinV5/MhBVGnKbkLM7NVRV7mwlajIwG0Kjmsdb3fNUjH9P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699279; c=relaxed/simple;
	bh=P6r18OuSK+PAUeCRKwBuZWKLTHf+Wb42PScoXeS/5Q0=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=MUNOEkHfRtjkc0spvUnw6gYflQxsTEzREQWh04Oz5Ij6NbkSp8/cUCCXYEVrJ8Fl4UKZvorlR50Vqqsm4SJrJGN8tVrx39hYXWHvpHXv/cFcn2PTqyooZpJQyp7p/tyyJQ/IQsDJokokAEKBgAjf5ghsheKEb34p1kfc65h6LCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XlAwjPyU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kjJauOtt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMTKO6032092;
	Thu, 27 Feb 2025 23:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=uzGGljK9pmf0F4IuqU
	iDsYbsPQndFOxv77raBvi6aVM=; b=XlAwjPyU3ICGxd81Qd2tdj+ZeWUu4Lt/mP
	CtxssKSpg66REBsrkzVGyji+LIB/xljBapVzcUTA7b1CsDJ9FihHE+8eHc80IO1L
	0CvidZZJuzbTttT4522lQ2ITufidz4k4yB26TpnDf4sf34xQrcEFYQQtAg+TldbL
	qrpMUyBbKYkqoT2aNfNUY3o4w75uHcVYrUgc240/Vky1zMfUG26xGRjjS+6tQVwk
	t69rHqksBAa1F3hyaVqj9K3/t89onxa1dPze1SZ1SIWEFvtr0+ni9OuP53YZ2RBs
	Y0pcO4opQHPLFavIp2xNljLTmnIyf1XrzOw1ISnAHJL6zXqukc4Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psccme9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 23:33:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMkSBZ025485;
	Thu, 27 Feb 2025 23:33:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51kf50t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 23:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFIpGU14Qp0GZVQ/zEUGp/X868xJB2xM5AEUw/NxcaEbJOR3UJedkJuLNqQtaUTznEy7GFS3mE+e5gWuCIqbRo88Hqw4tOrGiJqQQOprF0NveurGcjN5TukJI73UKMNwh4QhNOxTuzfmG2Gf02Iaa7b3R6YnAVsH+/DMkdh0sne/zdhxkJQlUg2oCBgfU/O5Waf5o0vF98iLWU1fFsCHqo1MgVV2xKvlapjrEyk59gNgCs/OiISWTpsJl2gQINHPxzNoyd53F9TsY8ESB8kXrysEX4rkh9oqX8VcVat0ojG0why1Rgspt+gSeNFjPzyMMCPGRmNlMuf9GDaoq9eNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzGGljK9pmf0F4IuqUiDsYbsPQndFOxv77raBvi6aVM=;
 b=xvxygqyV8ElI9w9z9NBCGWji6R4pcmjhJwZdEU7ZVKp0xi7iDq96R4wbDI5sRxsJAiwJPd20JH6S4q2RffJd1lyxUcTec/IlLEOomJmpCs8uW8w3s/ZQhdh3iB2fwYg+yuD07VnwQwX0/cmjsmkEdRROHNbtGfduYIhanqNgR5eCMQnpgMnL7HU2G5PToDXZgkQ4bNMgys/ruuTYzvAmRoSR60uYhPHSdywCRy/fXqhSB9ctVO+AQB95T7TVSVn1JzxtazGqMm1ntTRjIGRSGtzVpLLmU1VAJkbfXg5QZpB0PQb2A8gQ8veIV7eDSn+DEn+04dNniXfX2nrl0+cKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzGGljK9pmf0F4IuqUiDsYbsPQndFOxv77raBvi6aVM=;
 b=kjJauOttJyfVb+1qiMUKRD+8Pq3tFNXtyuruXahH7AzV8e3HQ27EOWX5BCEBmPuEtxi+iQtLJbUuy4AkIlBJa93XUD57qdwvfaa1QZ4LFNnilafTjcVowLud0Y4dWpzGJSyYhNHAaDWEfedHsWL7f26F+oGfPxmBG8HP2iDiKhY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6508.namprd10.prod.outlook.com (2603:10b6:510:203::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 23:33:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%2]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 23:33:06 +0000
References: <20250225035516.26443-1-boqun.feng@gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic
 Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Uladzislau Rezki
 <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan
 <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Davidlohr
 Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra
 <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent
 Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann
 <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Masami
 Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams
 <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH rcu 00/11] Lazy Preempt changes for v6.15
In-reply-to: <20250225035516.26443-1-boqun.feng@gmail.com>
Date: Thu, 27 Feb 2025 15:33:04 -0800
Message-ID: <87mse70xqn.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e203f84-2a3c-4724-2864-08dd57871605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XYbd0LRnKmxZyac+xaDCCu3nfpK5OjdlS0xkfSCWP+4W6f7KhQWA/9prhYrk?=
 =?us-ascii?Q?GDzED+u9424PcVGrjOt6FnEAbZhTyN5+qFaNXJn7bBiiERvFuUxpNpes4wK5?=
 =?us-ascii?Q?DPK995vKniBRT94c8b5EWQaCI/JEjSCbcm8NEr0EjDkNng+2JGRY/icS0rZI?=
 =?us-ascii?Q?CBZ0YUYCQ+oaJw/F2wjjjHTScuW0xqOo3k5mJS5SPIVz/aLg4bNoUnwc87B7?=
 =?us-ascii?Q?8THfdWmYrKK/2SXredsMd2RAcTZdw1C5V5Rc4jDhFF3n16CBphO+GZZbKwBR?=
 =?us-ascii?Q?nsMg/4w1RvrzGnpE7wp7+dwYnfHrx4DLY00ny19FoDMfKbj28BdTyABuPCVz?=
 =?us-ascii?Q?1YQMwvgNbRAouQNURLvNTsWAfUI0kJv320b1OCFkaod1j+iGt1TJjo8LgeQ6?=
 =?us-ascii?Q?f8oCyveu8Tv3A7cIg79MH+lvf8EDqKIinXcC9a5e2iXRZ9bZQ4WmpXOb5kKe?=
 =?us-ascii?Q?CPl9HnVCyWAfL+7wiX+Hta2AZSO++NUOd8m0b2zfKStxD0Xvsq9lHiKQ3K/R?=
 =?us-ascii?Q?w5xyLNF/NCjsBckhZuXrmcwLOX0mCATq72DNj87MUSltimA0ATHcglu35mEq?=
 =?us-ascii?Q?fYXOzDXA4tXa+4kQEWcrMl0EUuI4ppa7HWQwz+lKo6hOuyNT/AlOGAZxsCha?=
 =?us-ascii?Q?H41jTq6JiSGZqQwW9b2zfde4g4LQYu71u7HoUxnQyEeh/Do98Hb8CFw1K/a5?=
 =?us-ascii?Q?+njMbj8VBI0hL/pm7/Rvo8h6qIcTDMP95mAvmP9r8OJSGLSXbDIsF4hYh6Pj?=
 =?us-ascii?Q?OLKzmZ7vLMNqgq54AKAeqikoWszLn1jv7xeIhcArDmCY7+i1xiGB88AyQACu?=
 =?us-ascii?Q?j270rFdTkE+lyvHKUPMP8nNQ8H15L3ZXqdyw8dQuT9R+lcIIEMgaLM6HGZCW?=
 =?us-ascii?Q?4opW13owyKOxoqlRRPFbr3/PSN2dXCxZRnFN+wkV9JxRBGL1lkkg417JGiZa?=
 =?us-ascii?Q?rGqZORAuLydaBPdV7LPeCCttqbiBnUayxmaBpt4p30ZtiTPSwbOizp/navF2?=
 =?us-ascii?Q?+c/qSWlXLl9ec1cfDE5mRphXeTjkOhYIIPes7hwO/XYek50mKUIh11/re7Ny?=
 =?us-ascii?Q?zEzDjBovza2mpgDdxLzlVn9jVnPS5misdLIH/A9OwHT8F0w+3Mh7MDiR+9sl?=
 =?us-ascii?Q?mWR6M9A1oM0S/V0oygyZZhhVoLlSMfLaXNqApAetDkIYanelbe/sMizy1nFg?=
 =?us-ascii?Q?AXf/xLEGtWZiqfMbClETy4519koz3LKBFDzcxDULbOBf+rdGNhbLw1t7YliA?=
 =?us-ascii?Q?TXzuOk8Oqw3f72RUBYrY7d7dS4by+tagXse1+04BOIg2VIOD6mZqyFOCYSGP?=
 =?us-ascii?Q?WIfsNC3GdKTMAVD7s3/2lQ6h8I3jMjWJ5QIovR3F5CyAMeojRy/wwPrl6lYm?=
 =?us-ascii?Q?8rJRt3BaJENyJ2iNVb8lu0HmP6iA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owStA+BFHC3OBTf//dFswuilkuTEM/3W/FhoquG49/Y97G72mvOpkgrMzHE/?=
 =?us-ascii?Q?z2JRfuqvZGniPKZeJoEDlXR2OhZEl4yTlBX4HOV9B2vdGx7KBgZvAsaOedS+?=
 =?us-ascii?Q?/6PTLlhjURczojz8NRGBS5UoQp6g1x680B+RQxqoBM9P3tgBhDE3L4xhHwWK?=
 =?us-ascii?Q?gGEMakQzd57HlaHn/u0b/Iq8GC+i3va85l+aPis8tQSN7rYXfsj8TH49Av6M?=
 =?us-ascii?Q?RDpRxIRFhTav7UZnF+M3lxcuDvLDn1PxbDk66XiwO/5yQKNk0TQOZ/7cr7+O?=
 =?us-ascii?Q?WxVqpG6WUdUipmQnVS+chS4mZcwB7tr7s3NNoV3YXHNLdnRdWW6ZcupyEbfR?=
 =?us-ascii?Q?6xMGH6WaAlJG7uWli0rhDDHb4TakKGz5wmXb+9Gq9klJ84pJBjAHCfSOD8NF?=
 =?us-ascii?Q?sGfT0dO6ldu5hzrcwHazHSAKpg1NlQx0OUR1c6sKglx5wllMn/2x/HibML6y?=
 =?us-ascii?Q?oYLPzOVjmVOUs+SZZGSBBnv1SaM2/prkzuWshnQnIWti/X0GrhUMqQf55kiu?=
 =?us-ascii?Q?3e6GH7UqxxIObGZRpQbYkxeGbIAD9cjMC/vUa8aK5biEkLXNCGnf8v03E2m4?=
 =?us-ascii?Q?YTqZgGYCzO7iTFfdrre7Yk0uG87EyE3kr0UWUBWz93OIJRZxrvLMB4u+USuU?=
 =?us-ascii?Q?9Ih43AoKZbx+6m7EhlPt4bIlj1GwCYPGIRYXDzLjkdHWE0Mk5yozGpYZppqw?=
 =?us-ascii?Q?qdoSx1r53XrGJz9+bsxECaFCR2QFOIl26YltWqmriH3mdvg87VAOtxWqu+9l?=
 =?us-ascii?Q?QJRGmdYDSemaoVBCFST8Q3ETya2N/VTN9GxVqFeHcU1DoNoCcLT0WN9t7YFw?=
 =?us-ascii?Q?tEDw3liE5az54WUJYy7jdMwjILFUgh5YV3IQkqtJgmwAcx92u8alL8GKcp5w?=
 =?us-ascii?Q?elS2qMk39c2a4gAqDzGj/MLaehCUdHJMnSEu9zYiJr5ail+j7EYXI0fpNPF1?=
 =?us-ascii?Q?TSH6VSOmugW9X7mR828axN60HKunQhYpUfbFWq47yiLSnvb6jNTbcF7lcvko?=
 =?us-ascii?Q?fSIv3pN1roGixCRTs6t8eKcEeAhc/4LfmaX346w8fzDG4eytmlnKQiM2PFpu?=
 =?us-ascii?Q?bkUVNStDaQ7/nJE+YFEs5o2TdS6TYImsQMOP24NGRbsihHT5/fjH88m0fX/a?=
 =?us-ascii?Q?9CV9i0RBnWDjAIpJjTZd+zdC6qi8Sy/pXCkp7jgyyFWmVVII5aBSpflYgk3O?=
 =?us-ascii?Q?c1LH9EgkjvweyCkqmJTCVHvshf5GeUVSg4LU7JyGffDIoMCAdgmdCyUk5DVx?=
 =?us-ascii?Q?B6gMYxs3RpyiHKXDXKLF4qyfB7xzlet2EngBj1I064TI4/C1F8oE8hcDGZiM?=
 =?us-ascii?Q?LHty9CZLrMQ0O8RURPGEOvWxDP1wwzj9JAdaT6tR7oXOK4j4nMLjt30kKSI/?=
 =?us-ascii?Q?/DORZDmrl+tc4DBX1zzDZfFODkGSOCbXRyRrOpswlu6p7fNK1oJnSQH6fwrd?=
 =?us-ascii?Q?CuC77kt3DfCORxcwUtii4FF4lEsLDpRf6Chu6lKnQ39hZyzMCuesBHQGAPMK?=
 =?us-ascii?Q?wHBIono/GN+M+AVgDAij7ch+w2UwY0HTqrZLbFnHM30pIRj9ZBsvmRoCx3Mm?=
 =?us-ascii?Q?07ACOL+dUCpzKjxczPuZexyp/XB5B7iDZwuAAlyZUFxfc+uOtkum8ZgEyQhk?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UgxjJtA3OVDafg+jPltcoQGElIhU8vZppaTnTiUJtmfKZ27aJilhvCUEWcAs88kjwq2FFDnJq9VInGkEToItwGSCUc6UJfTelBLw0JJXn+lx2DskW+xs/drShXuo+9P4bgyxZ0rxnPKhOfOvrGermBnLL5lxIzvD8Zs4aIUfANcV0EI/4mS9pYuJCyBnSFVvzWC/vg3ABrPRpaQceQlpc148kgqSgVW4aNvlvAs7eErxwdVKODqeXsKh1AYqWqfftgKGQt4tcKcKcjsOvmoiCju7mhtEtIrkRUFsgpus5tvVUoYWhDkUx1Q2PWRMiPjvGkvNKtRYoUWZgBHrzyLMyDcV9T2+4L3LPcLb6mo/w5AnR4TjhLUTEK/pMQFXewF95QzMlUfNJb2ypNfROG3MY2Vp0NJs+OgXEc+U/YyH9TWIG+ifrJcgbLKBwdt9OKdAHi9UBrahPPAJz+VfmvTMWEyNVaGyYTfKPT9+BOINENIvMMQs6S+KCzQrh8fRhdOjQrct5is1DInqdONvBLWOPXOGaTWjhmT+7s+OOqgsVoe/S8nVzHEht91Yy0/mKRa+Sf8AW0+emS4SC+FQA+qLBKQzkDFZmU76MJdzjPfmjX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e203f84-2a3c-4724-2864-08dd57871605
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 23:33:06.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbDUtV8v691FES6vvTpM/Agd9cVQ/gFXV82r9htNf93jyEG3neEkhGe50KS5nSLYUtkFdezzjQuQ2QnLPiPEzr0zFDV0ajvC82NLpCQcySo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=549
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270175
X-Proofpoint-GUID: aqaf0ewwIbLRC8kZdaxgFQpR60Wv2ATs
X-Proofpoint-ORIG-GUID: aqaf0ewwIbLRC8kZdaxgFQpR60Wv2ATs


Boqun Feng <boqun.feng@gmail.com> writes:

> Hi,
>
> Please find the upcoming changes for CONFIG_PREEMPT_LAZY in RCU. The
> changes can also be found at:
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git lazypreempt.2025.02.24a
>
> Paul & Ankur, I put patch #7 and #8 (bug fixes in rcutorture) before
> patch #9 (which is the one that enables non-preemptible RCU in
> preemptible kernel), because I want to avoid introduce a bug in-between
> a series, appreciate it if you can double check on this. Thanks!

Makes sense to me.

--
ankur

