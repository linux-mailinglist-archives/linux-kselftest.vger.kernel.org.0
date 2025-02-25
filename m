Return-Path: <linux-kselftest+bounces-27500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E98DA4488C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EC43A7FAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495201A08A3;
	Tue, 25 Feb 2025 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mq8eK14e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04B19DF81;
	Tue, 25 Feb 2025 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504384; cv=fail; b=rn8KIf0cWONPncp//5oun5slRLy6BE2/YMCPAZ07SFSxvhBL8c3sjNGha2WWd91FFRCTsqNjOtehXg+JxHyxCEmgb7l0S1RErx2m+5Fq0B2yn+ItW+sG36iwrOVoCDESVyjjSeEvYqhOe3+I82+nit4xmBbFduT86jQfN3bKmTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504384; c=relaxed/simple;
	bh=ruU3l6LO3gcvQMJ/McVT7Z4wcUdf7zVyHJ18oFpZPsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBFuFQYMUvrD5Y5FVEHlfW+JWORtrrgUn+jVS+eVgeRNFwMiWaJ3Fvt1gG67tD2EjZKCTaD8J/HOqXbL3vmZAWJfq9Dj6KDK0RhuVFH7WO2t3x0y2jhlZfodioIqitaczgThvC3IPAIq6WfeWghhuzCdfNMLUBLqOgP5FzlmHuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mq8eK14e; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/sgLNSieDpVl+5bBa+gzWPfF2UTgoJyDPWsFysR02yX5z4Ev3lBmuLag57NQ8NZcCWFVPGCTrxGtXjttENOoqss8a6w57RmEa3Pi35N8Jc+SY1m4rz7+uyTpj2FJPszvIm17o8rxH6NR/U9r7nwrMerwQslmL18rmOu18NPHHJ/FscPWw3rT/68phKP45+mV0K/GJhxi3SfDaFscoB5ZGce6wMn+aSZbJN8Y/VP7487qQPj7uCaTLFRYdad0jgurMG3wbW+4itvIDsRuVzomrtjDLApfx2A/syywSi3X73suLiA8NGTNJn1EkgKG3j8OSplFxGzuyYrxdYjljz1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkfPylT5fZJ84edFbny4xMpZcPqfkqgdYNkiG7L9kJQ=;
 b=UQ5gvKsQDnAT8Oht/FulKhh+GN15lJ7qeaIfBGnz9i3vURbdymjwS7KnL49VQa+/eiTznGH7OjxMOmh5BhE8aamUQsmhxp/e1z5gRLcnaEEpeVbF7pOowkUvQFak4H1ozxjkD+0tWwH4+4z1fKyrkzLLLOM7XDG78ritxh1Ek/vyRBMchRVQran6AErTln+WDFbB99LCxrcET92RXSGnBDCF0AWUiyjIG94TKxwWivJ/f2kM6GI2RhxNknogv3O3G8RFdIYzHEBjqGZYg1WurBPpdCGiA+klqRFhbtmuVSLnjjG06gLgRAPM7GNG37hSql8qgRA4Axt2KERCVuUY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkfPylT5fZJ84edFbny4xMpZcPqfkqgdYNkiG7L9kJQ=;
 b=Mq8eK14eXt6ZgJPP+Kor62meP12TPijQhV7c29IXZEBrfdUX99px7aKYlDlkFFzfszpjdKD5F9H8XWkOxEK6Eks29cZ0q/oNU2BgeVnJyLmLIroW0HqnK5dXPgbMcZTJN0ZDfMTuE0IGcSwV2FRjO1qIwyAS/XZ/ebKw4RaVrKRlvpFeUjmMEc5E9VK6AX+o5w+t/HAk8J9XJrj4jcXlcnmjggscYypGUee/PNW/apVrU1Rfm3HkIsPhqWzgb6jXgJkjnm2XJ+MKasuD5E25DxIc6Csymxl/hkHuIF0IRLjr+wvunfRli17SU0DFCtXR0i8dlG2KXxflIxhcsPwDzQ==
Received: from DM6PR07CA0099.namprd07.prod.outlook.com (2603:10b6:5:337::32)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 17:26:14 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::63) by DM6PR07CA0099.outlook.office365.com
 (2603:10b6:5:337::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 17:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 17:26:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 09:26:01 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 09:26:00 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 09:25:59 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v8 05/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC
Date: Tue, 25 Feb 2025 09:25:33 -0800
Message-ID: <975ec3902bfd884014e8b3c24bbaeb37d77a00c5.1740504232.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740504232.git.nicolinc@nvidia.com>
References: <cover.1740504232.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d09d885-0930-44a4-b6d0-08dd55c1811b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zjurNtvHgZ5fQp2YCNfZpVYsyG5DJ+0+FEQSjQJ8TxEkU0+92h2nZdxr0of2?=
 =?us-ascii?Q?LrAhxKbtKQQrTnNnD2zfVN+a/nq/haHW65IRk+8bV0uq/u7VS1P+E3q+/asV?=
 =?us-ascii?Q?1iSzX4m5SsfJ674GkANlmGBDoCmksjWNTsohPpMaAn23QhtildbSbpZ4XA3Q?=
 =?us-ascii?Q?dgU2wmnxlG1Fx121IkriUiL1l0yKglj4A2MwjpDN2CQmpLz9IYTvkud4C6TD?=
 =?us-ascii?Q?AqgOHbqSUtyIAxCaKenv0tDJXc/mQjm19tANi9zKValMnh3e4iM8z4pg03Oz?=
 =?us-ascii?Q?fPshE6PG3BEoDnEuL47lg657BScue3IHE3PYfjxZQZkzszryaEf3la1EreNt?=
 =?us-ascii?Q?6I1cW0tnNDy23Jb5UWpxSjbLMornfljjwUioQyUETV1Dr+TRPiOGSDIXIbtu?=
 =?us-ascii?Q?ZGdt9qX/CC1UnC09y2pLD9tT4ESxCmD3z2/nZWVDw0M3TqNc6QpzDGfDt7eD?=
 =?us-ascii?Q?lrJXk0XqO+LCH5OYYtesi8cp3PjX0rIhIS+O0uutxWNgz2Ch6LpkNiYJYjLk?=
 =?us-ascii?Q?aIG4TC1I4lu3w76WCZfaaUS/H1nAU/M5HcK80imUKPffLcpOKNB5K+2WW1Np?=
 =?us-ascii?Q?wGXhqHjtLV15fzIu8F7fXzzuQ/RwSu9sfZPJuUOg1x5ytAypyFzxWiZyWXRn?=
 =?us-ascii?Q?jYpXTKBj5kU4tt21HGItYaemtDRgtrXU3qVuNq81jvoBUTS3nF/AL9epqHU5?=
 =?us-ascii?Q?oXnJ7pTR2jCepRXcEoi8oBFgiIXVYqv7rcmCDKUwGtu2cBtJE9M66uBAQL/z?=
 =?us-ascii?Q?X+8j59nL0afxhoLyOk1w4jSGpBl96kQ2wapR8VRdp0scLeT7ATMuLHIbxUsx?=
 =?us-ascii?Q?RR6jnEo0GGO5w9/raxDvq2gJSBZk7qFNb95VwN9F9zoQ8awsi1+Q7doH8cqt?=
 =?us-ascii?Q?7C72HCFNjwEt99mFUWSqBahtI+EKCLgGaD2RJbKEoQfD0sR/2lN/NKsfP0yd?=
 =?us-ascii?Q?UkoI5wftMOMx1Lm2ClxX+d1fe29rV3vx8i3thieBXRuK/1CUoAXH7bVssKYp?=
 =?us-ascii?Q?pOeOzVaePiUR+1g9fBRqqhNElJcTvXXXVupH9Bqu5FQiJyjBU/yOVjz0Vcmk?=
 =?us-ascii?Q?ExmfeTfq1ovsNCG3lc1wRPQl0k3HbkiG5SzQMMl5REgjaJY/vYBVnpQGQbkx?=
 =?us-ascii?Q?1fL2pnMPOSC8IpwdkxO6/T/FE3PXZTI5trwS+Jskn6wkzp1d/5OaSgMyhlME?=
 =?us-ascii?Q?vyE1XdacdoDB3NwfVOfp4OsGFesZVjMIwFqi7J1aDVmUB7o4nnCdVyRFUhDN?=
 =?us-ascii?Q?IiUWLdXaV3QpryN8nYfg86IYQh+f9/8pM212oE4cxPBd0zHmHYG4bW4QfF87?=
 =?us-ascii?Q?5BYvmAJYuvZZRhUXreQZzrvHg+O7suBKAbbnqFMTFVsqijd46UyuR7ml+bAO?=
 =?us-ascii?Q?XzX56NZ6ii4Y4nsTxmrzurluqBBIQ9bcom8hskkl78sEUbKvzZNaCTkMySKS?=
 =?us-ascii?Q?E/R0uu9O5tXquygjv9WtuLOFvc3mZzrUixE6Vf9urjGIx9oJETpgVp0rohrc?=
 =?us-ascii?Q?CXE+KEtuYrmq4lY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:26:13.8042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d09d885-0930-44a4-b6d0-08dd55c1811b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466

Introduce a new IOMMUFD_OBJ_VEVENTQ object for vIOMMU Event Queue that
provides user space (VMM) another FD to read the vIOMMU Events.

Allow a vIOMMU object to allocate vEVENTQs, with a condition that each
vIOMMU can only have one single vEVENTQ per type.

Add iommufd_veventq_alloc() with iommufd_veventq_ops for the new ioctl.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  82 ++++++++++
 include/linux/iommufd.h                 |   3 +
 include/uapi/linux/iommufd.h            |  82 ++++++++++
 drivers/iommu/iommufd/eventq.c          | 209 +++++++++++++++++++++++-
 drivers/iommu/iommufd/main.c            |   7 +
 drivers/iommu/iommufd/viommu.c          |   2 +
 6 files changed, 384 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 44fb30af10b0..8cda9c4672eb 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -507,6 +507,74 @@ void iommufd_fault_iopf_disable(struct iommufd_device *idev);
 void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 				  struct iommufd_attach_handle *handle);
 
+/* An iommufd_vevent represents a vIOMMU event in an iommufd_veventq */
+struct iommufd_vevent {
+	struct iommufd_vevent_header header;
+	struct list_head node; /* for iommufd_eventq::deliver */
+	ssize_t data_len;
+	u64 event_data[] __counted_by(data_len);
+};
+
+#define vevent_for_lost_events_header(vevent) \
+	(vevent->header.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)
+
+/*
+ * An iommufd_veventq object represents an interface to deliver vIOMMU events to
+ * the user space. It is created/destroyed by the user space and associated with
+ * a vIOMMU object during the allocations.
+ */
+struct iommufd_veventq {
+	struct iommufd_eventq common;
+	struct iommufd_viommu *viommu;
+	struct list_head node; /* for iommufd_viommu::veventqs */
+	struct iommufd_vevent lost_events_header;
+
+	unsigned int type;
+	unsigned int depth;
+
+	/* Use common.lock for protection */
+	u32 num_events;
+	u32 sequence;
+};
+
+static inline struct iommufd_veventq *
+eventq_to_veventq(struct iommufd_eventq *eventq)
+{
+	return container_of(eventq, struct iommufd_veventq, common);
+}
+
+static inline struct iommufd_veventq *
+iommufd_get_veventq(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VEVENTQ),
+			    struct iommufd_veventq, common.obj);
+}
+
+int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_veventq_destroy(struct iommufd_object *obj);
+void iommufd_veventq_abort(struct iommufd_object *obj);
+
+static inline void iommufd_vevent_handler(struct iommufd_veventq *veventq,
+					  struct iommufd_vevent *vevent)
+{
+	struct iommufd_eventq *eventq = &veventq->common;
+
+	lockdep_assert_held(&eventq->lock);
+
+	/*
+	 * Remove the lost_events_header and add the new node at the same time.
+	 * Note the new node can be lost_events_header, for a sequence update.
+	 */
+	if (list_is_last(&veventq->lost_events_header.node, &eventq->deliver))
+		list_del(&veventq->lost_events_header.node);
+	list_add_tail(&vevent->node, &eventq->deliver);
+	vevent->header.sequence = veventq->sequence;
+	veventq->sequence = (veventq->sequence + 1) & INT_MAX;
+
+	wake_up_interruptible(&eventq->wait_queue);
+}
+
 static inline struct iommufd_viommu *
 iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 {
@@ -515,6 +583,20 @@ iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_viommu, obj);
 }
 
+static inline struct iommufd_veventq *
+iommufd_viommu_find_veventq(struct iommufd_viommu *viommu, u32 type)
+{
+	struct iommufd_veventq *veventq, *next;
+
+	lockdep_assert_held(&viommu->veventqs_rwsem);
+
+	list_for_each_entry_safe(veventq, next, &viommu->veventqs, node) {
+		if (veventq->type == type)
+			return veventq;
+	}
+	return NULL;
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 11110c749200..8948b1836940 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -34,6 +34,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_FAULT,
 	IOMMUFD_OBJ_VIOMMU,
 	IOMMUFD_OBJ_VDEVICE,
+	IOMMUFD_OBJ_VEVENTQ,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -93,6 +94,8 @@ struct iommufd_viommu {
 	const struct iommufd_viommu_ops *ops;
 
 	struct xarray vdevs;
+	struct list_head veventqs;
+	struct rw_semaphore veventqs_rwsem;
 
 	unsigned int type;
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 78747b24bd0f..2ade4839880d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -55,6 +55,7 @@ enum {
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x90,
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
+	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 };
 
 /**
@@ -1014,4 +1015,85 @@ struct iommu_ioas_change_process {
 #define IOMMU_IOAS_CHANGE_PROCESS \
 	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
 
+/**
+ * enum iommu_veventq_flag - flag for struct iommufd_vevent_header
+ * @IOMMU_VEVENTQ_FLAG_OVERFLOW: vEVENTQ has lost vEVENTs
+ */
+enum iommu_veventq_flag {
+	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
+};
+
+/**
+ * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
+ * @flags: Combination of enum iommu_veventq_flag
+ * @sequence: The sequence index of a vEVENT in the vEVENTQ, with a range of
+ *            [0, INT_MAX] where the following index of INT_MAX is 0
+ *
+ * Each iommufd_vevent_header reports a sequence index of the following vEVENT:
+ *  -------------------------------------------------------------------------
+ * | header0 {sequence=0} | data0 | header1 {sequence=1} | data1 |...| dataN |
+ *  -------------------------------------------------------------------------
+ * And this sequence index is expected to be monotonic to the sequence index of
+ * the previous vEVENT. If two adjacent sequence indexes has a delta larger than
+ * 1, it means that delta - 1 number of vEVENTs has lost, e.g. two lost vEVENTs:
+ *  -------------------------------------------------------------------------
+ * | ... | header3 {sequence=3} | data3 | header6 {sequence=6} | data6 | ... |
+ *  -------------------------------------------------------------------------
+ * If a vEVENT lost at the tail of the vEVENTQ and there is no following vEVENT
+ * providing the next sequence index, an IOMMU_VEVENTQ_FLAG_LOST_EVENTS header
+ * would be added to the tail, and no data would follow this header:
+ *  ---------------------------------------------------------------------------
+ * |..| header3 {sequence=3} | data3 | header4 {flags=LOST_EVENTS, sequence=4} |
+ *  ---------------------------------------------------------------------------
+ */
+struct iommufd_vevent_header {
+	__u32 flags;
+	__u32 sequence;
+};
+
+/**
+ * enum iommu_veventq_type - Virtual Event Queue Type
+ * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_veventq_type {
+	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_veventq_alloc - ioctl(IOMMU_VEVENTQ_ALLOC)
+ * @size: sizeof(struct iommu_veventq_alloc)
+ * @flags: Must be 0
+ * @viommu: virtual IOMMU ID to associate the vEVENTQ with
+ * @type: Type of the vEVENTQ. Must be defined in enum iommu_veventq_type
+ * @veventq_depth: Maximum number of events in the vEVENTQ
+ * @out_veventq_id: The ID of the new vEVENTQ
+ * @out_veventq_fd: The fd of the new vEVENTQ. User space must close the
+ *                  successfully returned fd after using it
+ * @__reserved: Must be 0
+ *
+ * Explicitly allocate a virtual event queue interface for a vIOMMU. A vIOMMU
+ * can have multiple FDs for different types, but is confined to one per @type.
+ * User space should open the @out_veventq_fd to read vEVENTs out of a vEVENTQ,
+ * if there are vEVENTs available. A vEVENTQ will lose events due to overflow,
+ * if the number of the vEVENTs hits @veventq_depth.
+ *
+ * Each vEVENT in a vEVENTQ encloses a struct iommufd_vevent_header followed by
+ * a type-specific data structure, in a normal case:
+ *  -------------------------------------------------------------
+ * || header0 | data0 | header1 | data1 | ... | headerN | dataN ||
+ *  -------------------------------------------------------------
+ * unless a tailing IOMMU_VEVENTQ_FLAG_LOST_EVENTS header is logged (refer to
+ * struct iommufd_vevent_header).
+ */
+struct iommu_veventq_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 veventq_depth;
+	__u32 out_veventq_id;
+	__u32 out_veventq_fd;
+	__u32 __reserved;
+};
+#define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f8e60e5879d1..4c43ace8c725 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -262,13 +262,148 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 	return done == 0 ? rc : done;
 }
 
+/* IOMMUFD_OBJ_VEVENTQ Functions */
+
+void iommufd_veventq_abort(struct iommufd_object *obj)
+{
+	struct iommufd_eventq *eventq =
+		container_of(obj, struct iommufd_eventq, obj);
+	struct iommufd_veventq *veventq = eventq_to_veventq(eventq);
+	struct iommufd_viommu *viommu = veventq->viommu;
+	struct iommufd_vevent *cur, *next;
+
+	lockdep_assert_held_write(&viommu->veventqs_rwsem);
+
+	list_for_each_entry_safe(cur, next, &eventq->deliver, node) {
+		list_del(&cur->node);
+		if (cur != &veventq->lost_events_header)
+			kfree(cur);
+	}
+
+	refcount_dec(&viommu->obj.users);
+	list_del(&veventq->node);
+}
+
+void iommufd_veventq_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_veventq *veventq = eventq_to_veventq(
+		container_of(obj, struct iommufd_eventq, obj));
+
+	down_write(&veventq->viommu->veventqs_rwsem);
+	iommufd_veventq_abort(obj);
+	up_write(&veventq->viommu->veventqs_rwsem);
+}
+
+static struct iommufd_vevent *
+iommufd_veventq_deliver_fetch(struct iommufd_veventq *veventq)
+{
+	struct iommufd_eventq *eventq = &veventq->common;
+	struct list_head *list = &eventq->deliver;
+	struct iommufd_vevent *vevent = NULL;
+
+	spin_lock(&eventq->lock);
+	if (!list_empty(list)) {
+		struct iommufd_vevent *next;
+
+		next = list_first_entry(list, struct iommufd_vevent, node);
+		/* Make a copy of the lost_events_header for copy_to_user */
+		if (next == &veventq->lost_events_header) {
+			vevent = kzalloc(sizeof(*vevent), GFP_ATOMIC);
+			if (!vevent)
+				goto out_unlock;
+		}
+		list_del(&next->node);
+		if (vevent)
+			memcpy(vevent, next, sizeof(*vevent));
+		else
+			vevent = next;
+	}
+out_unlock:
+	spin_unlock(&eventq->lock);
+	return vevent;
+}
+
+static void iommufd_veventq_deliver_restore(struct iommufd_veventq *veventq,
+					    struct iommufd_vevent *vevent)
+{
+	struct iommufd_eventq *eventq = &veventq->common;
+	struct list_head *list = &eventq->deliver;
+
+	spin_lock(&eventq->lock);
+	if (vevent_for_lost_events_header(vevent)) {
+		/* Remove the copy of the lost_events_header */
+		kfree(vevent);
+		vevent = NULL;
+		/* An empty list needs the lost_events_header back */
+		if (list_empty(list))
+			vevent = &veventq->lost_events_header;
+	}
+	if (vevent)
+		list_add(&vevent->node, list);
+	spin_unlock(&eventq->lock);
+}
+
+static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
+					 size_t count, loff_t *ppos)
+{
+	struct iommufd_eventq *eventq = filep->private_data;
+	struct iommufd_veventq *veventq = eventq_to_veventq(eventq);
+	struct iommufd_vevent_header *hdr;
+	struct iommufd_vevent *cur;
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos)
+		return -ESPIPE;
+
+	while ((cur = iommufd_veventq_deliver_fetch(veventq))) {
+		/* Validate the remaining bytes against the header size */
+		if (done >= count || sizeof(*hdr) > count - done) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			break;
+		}
+		hdr = &cur->header;
+
+		/* If being a normal vEVENT, validate against the full size */
+		if (!vevent_for_lost_events_header(cur) &&
+		    sizeof(hdr) + cur->data_len > count - done) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			break;
+		}
+
+		if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			rc = -EFAULT;
+			break;
+		}
+		done += sizeof(*hdr);
+
+		if (cur->data_len &&
+		    copy_to_user(buf + done, cur->event_data, cur->data_len)) {
+			iommufd_veventq_deliver_restore(veventq, cur);
+			rc = -EFAULT;
+			break;
+		}
+		spin_lock(&eventq->lock);
+		veventq->num_events--;
+		spin_unlock(&eventq->lock);
+		done += cur->data_len;
+		kfree(cur);
+	}
+
+	return done == 0 ? rc : done;
+}
+
 /* Common Event Queue Functions */
 
 static __poll_t iommufd_eventq_fops_poll(struct file *filep,
 					 struct poll_table_struct *wait)
 {
 	struct iommufd_eventq *eventq = filep->private_data;
-	__poll_t pollflags = EPOLLOUT;
+	__poll_t pollflags = 0;
+
+	if (eventq->obj.type == IOMMUFD_OBJ_FAULT)
+		pollflags |= EPOLLOUT;
 
 	poll_wait(filep, &eventq->wait_queue, wait);
 	spin_lock(&eventq->lock);
@@ -388,3 +523,75 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 
 	return 0;
 }
+
+static const struct file_operations iommufd_veventq_fops =
+	INIT_EVENTQ_FOPS(iommufd_veventq_fops_read, NULL);
+
+int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_veventq_alloc *cmd = ucmd->cmd;
+	struct iommufd_veventq *veventq;
+	struct iommufd_viommu *viommu;
+	int fdno;
+	int rc;
+
+	if (cmd->flags || cmd->__reserved ||
+	    cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->veventq_depth)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	down_write(&viommu->veventqs_rwsem);
+
+	if (iommufd_viommu_find_veventq(viommu, cmd->type)) {
+		rc = -EEXIST;
+		goto out_unlock_veventqs;
+	}
+
+	veventq = __iommufd_object_alloc(ucmd->ictx, veventq,
+					 IOMMUFD_OBJ_VEVENTQ, common.obj);
+	if (IS_ERR(veventq)) {
+		rc = PTR_ERR(veventq);
+		goto out_unlock_veventqs;
+	}
+
+	veventq->type = cmd->type;
+	veventq->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	veventq->depth = cmd->veventq_depth;
+	list_add_tail(&veventq->node, &viommu->veventqs);
+	veventq->lost_events_header.header.flags =
+		IOMMU_VEVENTQ_FLAG_LOST_EVENTS;
+
+	fdno = iommufd_eventq_init(&veventq->common, "[iommufd-viommu-event]",
+				   ucmd->ictx, &iommufd_veventq_fops);
+	if (fdno < 0) {
+		rc = fdno;
+		goto out_abort;
+	}
+
+	cmd->out_veventq_id = veventq->common.obj.id;
+	cmd->out_veventq_fd = fdno;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
+
+	iommufd_object_finalize(ucmd->ictx, &veventq->common.obj);
+	fd_install(fdno, veventq->common.filep);
+	goto out_unlock_veventqs;
+
+out_put_fdno:
+	put_unused_fd(fdno);
+	fput(veventq->common.filep);
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
+out_unlock_veventqs:
+	up_write(&viommu->veventqs_rwsem);
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b6fa9fd11bc1..3df468f64e7d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -317,6 +317,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vdevice_alloc vdev;
+	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
 #ifdef CONFIG_IOMMUFD_TEST
@@ -372,6 +373,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
 	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
 		 struct iommu_vdevice_alloc, virt_id),
+	IOCTL_OP(IOMMU_VEVENTQ_ALLOC, iommufd_veventq_alloc,
+		 struct iommu_veventq_alloc, out_veventq_fd),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
@@ -514,6 +517,10 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
 	},
+	[IOMMUFD_OBJ_VEVENTQ] = {
+		.destroy = iommufd_veventq_destroy,
+		.abort = iommufd_veventq_abort,
+	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 69b88e8c7c26..01df2b985f02 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -59,6 +59,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	viommu->ictx = ucmd->ictx;
 	viommu->hwpt = hwpt_paging;
 	refcount_inc(&viommu->hwpt->common.obj.users);
+	INIT_LIST_HEAD(&viommu->veventqs);
+	init_rwsem(&viommu->veventqs_rwsem);
 	/*
 	 * It is the most likely case that a physical IOMMU is unpluggable. A
 	 * pluggable IOMMU instance (if exists) is responsible for refcounting
-- 
2.43.0


