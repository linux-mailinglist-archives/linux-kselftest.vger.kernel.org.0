Return-Path: <linux-kselftest+bounces-31812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2752A9F911
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 21:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013441A85B91
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 19:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C727B209F45;
	Mon, 28 Apr 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hHCYjTWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389751C700C;
	Mon, 28 Apr 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866850; cv=fail; b=cvTQWtHRVWPwrl6isZSuHSAPCq8WrDMnRxIXza8Zw9xCeGqQzr5C3ZTyHNaODxNiILQK0oDiA0w/yQHTTJlvAhN5GdJQhPsy5G5qbUVmltFr+PCi5OlNIRJjrQAKcAl667novJxYs3X+TYMv2hD3MX+4JaTrLQgSFY05c7iDlvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866850; c=relaxed/simple;
	bh=rTVb+0CFffWq4TZogj4L2UzCxWukRrtPh/jPmo+Epmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwhVs0YCzUvjdxh90o2ERnT10jqkRBT0upO4W7u7qq0+4zTUVF0UplIyC0iSxaceRs9QlsYWom5LFDK7GZdxCp09EoRpT2V/mwzy7BVBGkCxpxZr6q/GX9z8ia5uopkg7a+9LFqL7u302/GYrx8Yauo5gq9lGH5cr4D3R9SSdAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hHCYjTWO; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX/4pbrQY0zgQ7GZbF3ogz4Ti5qlbqZAObhbpSzGTTpw3/mkrIYbz4TxPg/VDHuajWCte0q7tL9tRW9L0ae6dPY1Ia94TpZAekqPzSMb5ezY9sAdZsXOMF/irZmR4gGb4d/n0YqFS4reo9ibl6w34MtMOW4u2hB15aws18h40G6QI5IXiw38aC4qRd5d0S54bkNpwuAh2CULU5ifHfnCTo1ZOj0h1971aQ5sO3xBwElXiSohLVEgDybCg7rOaSpMIaysJe48Y0dZWEWMug1rGM4czrW38+LRXEMlg9ZfVx95XCyIvrQBbkD3a/taTGJUDoNCBw057arpA9BC1W2Kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcyWyIKSCTzI5AimZXIVPS4xBNZB3EtI6M/x4noiUY4=;
 b=TdEiQaEW9EHmQ3mhjPPynmFqRsyg135/63/X5UdUC4V1r/XT3C9Z/qnDAugr5GGpDTCvXK1bmqUESjspakoJKhlKIUXimllfySHPjIUWLdMlfedqDylLJ7jaXcUzNYlhwbKFVxWdQpxF/e+K3SalbCcmQSxck0XphzdoxgtgOl07zmFcQkWOQH2JCmh1MGTLKnwksl0x3xWVpcYB45dPRTwom7f6348TnKGzVgKQtNhKIvsLL8qSjFqyzDgVZA+JSQGmANNiXpOxuy4KvXeKRAwjqfYWN/gnEtNSCGy2GBWVkjYFVpWKyNPVfeY1hu6SXxhnNe1OOcbogtMODmcXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcyWyIKSCTzI5AimZXIVPS4xBNZB3EtI6M/x4noiUY4=;
 b=hHCYjTWOUxqMDGsHiPpguOjfefJB9xkCbKuh1v9SVFFsqkWcK6W8/9BhFkiA5lPnMA0mJQ5j9gmWKG3haD8el/l7JNAc+BzDxEdSmNU6EgA22HfWzidLihwhKqp3syrhUKw6cUhjRD0474zKhAQuzFWuP/9ikQ2BB4oOT6uD5A2dnCuFArI2zTuHzzUdPUvG5PK9NlP1B7DOO3dYV/itSue6SgWSAhdcL+K8BZKMXQYYp9xIykYCE6n8Ie3nGKVZ3u63lm/LcTs93OnEzc7ECDbazZus9tvI0h2OOq/YvOI/gspZFrYAOWv2gEnh4nZatuY3ZIhsl38PaSGZ3SkKOw==
Received: from BN8PR03CA0003.namprd03.prod.outlook.com (2603:10b6:408:94::16)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 19:00:46 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::6a) by BN8PR03CA0003.outlook.office365.com
 (2603:10b6:408:94::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Mon,
 28 Apr 2025 19:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.2 via Frontend Transport; Mon, 28 Apr 2025 19:00:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 28 Apr
 2025 12:00:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Apr
 2025 12:00:19 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Apr 2025 12:00:16 -0700
Date: Mon, 28 Apr 2025 12:00:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 15/22] Documentation: userspace-api: iommufd: Update
 vCMDQ
Message-ID: <aA/QPhB+7PM3GDEq@Asurada-Nvidia>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <820dfdee121292fe4cf891feb86f82ceea521e22.1745646960.git.nicolinc@nvidia.com>
 <aA-RQwyTS1m4CuPw@archie.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aA-RQwyTS1m4CuPw@archie.me>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: e584fedd-2e6a-4dc7-0024-08dd8686fb95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/2ctnPy9/Wn6DUvR4XrwTt4kMFBYcRFQESF9l1ba9xEowVEwuozopGAVFM7?=
 =?us-ascii?Q?x2e/VRzQJ4gVV0nBvDWO9yLSe0Lo9RAJDFPbXBDhGBKC4XcPa8z3fNd4L4fb?=
 =?us-ascii?Q?LuSwp5pAVeD/bOx1qdvlsumuzYldqU5w0fi99eUvihT6jf5XSydG2rXIU70e?=
 =?us-ascii?Q?/gAAp2vaig2ALgAvQoPH7HcCHAZfqr5CQazMNYOb6TX76do+3e3+ceZsBzHD?=
 =?us-ascii?Q?C5q1X8EP0J9uLsq7fiOjens5SDQE6CAEPxMfK6+arrxh8qlQ67McU3MGmpKi?=
 =?us-ascii?Q?sIOT5cQS8V4PIpBRoQKEb1z+SnuSXfFJJZp+Ong9oLrkAi3Wmsfrls+tXxmI?=
 =?us-ascii?Q?CY7TgeWHSY0xhrNa8VaMNrIY+MgYx3ZbOKkheBt9L/a8hWnh+AmIsjKuMBPy?=
 =?us-ascii?Q?HZZjdIhJIVdZOqtlTi+4r/Ei0YvR2dwMOMVF9TXV6TrEfyWbiYMz585pbTW7?=
 =?us-ascii?Q?JfXYhMMCZQzzeMKIDRds0HADbe/eAVobQPoxfJLhev74qPDAP7wz1m6DAyp5?=
 =?us-ascii?Q?2Ydu77zUDDpHxkbuhs+BHSTKB01SGfn4rIQec/2C6LFgdTncM7W3dRQ5HMTR?=
 =?us-ascii?Q?IGlgKQbdkoJdbkYgkt0x4bKL4XhJ4O06tkW5r2tlG8/vqhLNsB/qlGxZvHN0?=
 =?us-ascii?Q?p5KBs5+d+epyLKrqIxiAcJj9TqrAuxP29F+ikITlUIaQ96q4o4vtjC4705Mw?=
 =?us-ascii?Q?YPOjdvjJzpOb6X1YeoK54G2q3SHwKgKTQkm2dufS3T+3NPiURrAWk+WyYTDa?=
 =?us-ascii?Q?S5PH8iaIdaQdYFrw2dpuwEutbWtw0Iq5mCvcTwBdQYmnoBYODUU0S64qlXgo?=
 =?us-ascii?Q?Jc+CrBcqWwanYUNVxfH2v6CapODHJrlBAv8RVpoqpcvSRCsrph0nQ9GBC66N?=
 =?us-ascii?Q?rFl3mEP8OBa/g3CQRDUnDeRxeH6jksddkFsVt4cbF7FzSDIv9A2wZ4dLGyzj?=
 =?us-ascii?Q?ZrrBYzNJOEY99sWcoOMcRkD5cmSRbINyPAEqtvyjDIrHjM8VkSp8Y22IH+CG?=
 =?us-ascii?Q?ktg+fE2ut7tUaUph3jtdQwFCbY3G9BrS3Obrk9ZiTlzgyLHoRpEzYOk/RZcf?=
 =?us-ascii?Q?sLNsdlsAvjcWDNnMbc5WtbnqRfugQErk84YAGhPEH4q7BDQoRUoHCxoWKcEw?=
 =?us-ascii?Q?cAYDJRYVo/ijt7j+pkvh5IUHpjpJcv/8TqFcOefj/lIvyDuayMsrT38rDrzt?=
 =?us-ascii?Q?/Ae37CGQ0hzem5qkYXGcNSbmVIj/PJt8B88eqMdIuUQdFQ/xBZr7F+Czjhd+?=
 =?us-ascii?Q?Tr5QaKZFLu2H/XmKs/0NI0/XU5KUNmdWIKb217kjMQwXGEn1jMmQQqQ3eKBl?=
 =?us-ascii?Q?wv6+9bIkwu5qXrCuKAMEPZjztUQudHk7a8VMux1wf7qp/2fun2adr89t5r1k?=
 =?us-ascii?Q?0iWl2nvCAsWdNYaFWfKM5U4FNpM1NKSxXQvpgU5mM7v7o8JEFX/7xmHe44+0?=
 =?us-ascii?Q?oJI5fEdvvHnv0twAjIyO/WDZtWwFqbDkTGlGFw1WFHN1Q/fNV6gUbttaBl3N?=
 =?us-ascii?Q?rhH+9c+XkbUF8sobaSeveA6UeeQL+ps2WHwc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 19:00:45.9083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e584fedd-2e6a-4dc7-0024-08dd8686fb95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280

On Mon, Apr 28, 2025 at 09:31:31PM +0700, Bagas Sanjaya wrote:
> On Fri, Apr 25, 2025 at 10:58:10PM -0700, Nicolin Chen wrote:
> > +- IOMMUFD_OBJ_VCMDQ, representing a hardware queue as a subset of a vIOMMU's
> > +  virtualization feature for a VM to directly execute guest-issued commands to
> > +  invalidate HW cache entries holding the mappings or translations of a guest-
> > +  owned stage-1 page table. Along with this queue object, iommufd provides the
> > +  user space an mmap interface for VMM to mmap a physical MMIO region from the
> > +  host physical address space to a guest physical address space, to exclusively
> > +  control the allocated vCMDQ HW. Thus, when allocating a vCMDQ, the VMM must
> > +  request a pair of VMA info (vm_pgoff/size) for a later mmap call. The length
> > +  argument of an mmap call could be smaller than the given size for a paritial
> > +  mmap, but the given vm_pgoff (as the addr argument of the mmap call) should
> "... partial mmap, ..."

Fixed. Thanks!

Nicolin

