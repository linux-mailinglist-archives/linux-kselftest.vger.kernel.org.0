Return-Path: <linux-kselftest+bounces-27277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5F2A409B7
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 16:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6FB3BFACB
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BBB20C460;
	Sat, 22 Feb 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R35JsGIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B320B7EF;
	Sat, 22 Feb 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239697; cv=fail; b=ZKENmgLUU4IELXsIZDZIHRuCbfibOvtI4+IU64i6qd1MxTSItpNox+RBDpsF88bbOJUpuETep6MVQBHmBfLZXuyt0sfAtkdmCjGKp17bJJ/5iD+24Ti8AP660+raFm3dEc4gY2EbvBfqthaFzF9/YQ6FiNjN7mGY61vHBKb0+N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239697; c=relaxed/simple;
	bh=yJvub6Tg6pAbLvjjlP9rJ+GPjEemqPPrDlsYUpAU7Zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxR7uqNXOS/59lwWPomHfNbmcUhdWoEDQXL5q/R47w+/+Nus14SDbjU+2U2W8/n5g9ETx6VO38jQrXnTpyuY/acSnaFowLNZuImZnvlNika9mW8b0DShVaXwN8Op9RXckXgdSzim9RMDP54F643B+pzrUuJ5cq2EKJGg9db9xTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R35JsGIl; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjwD4l8rtaDKzurSH4kQl259j0Mb6w+ua5k2wVVT8ljEYS40bFNT9+mtapfHpaAbbpkFiMDcuLqVY3OYIhPKECZ/4+RAL3rba6LEpbd2j56taTOqb2cTxPpAWoQWGZvcjjn2WjdKukDr7Yi0iKaFk2xFRXbSr2IctwKyEgTgaHVOPY1OIVSlfQLA5R4l6q1GgU7XR9UKoqA+9JmHq/H3RMdmbYiOJFnSrJvq9lW3fOaWwaT96o4NsZuOUzVIrZDddg+9QwD+cnl3s/0/4mZlSU9xvcG6b4D+kjajRtjiBJZnZFnsfC2pWVOupiKXP1SXSpdwaiOkKk17B5qn3zAqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0kbEzCCBCwfliZYSwakktJXjjge9xvLJvx1Yf2MNKE=;
 b=CZJijKXlV7O8pwKX8thUXNWmJphYGlGltVNxXbapY9yulo6NVGoN2a5qP34o3ccbq2HYoj4r6sIkl1uWJShA42pkRALWEIKma1lqXX7zlQXKr++aEEGICXHTw0DktkdxqQ4scQ+iuKJ6Rs/uOgvvAqO9sWNg/61Td2c9k8HKDMBsC0UeQqmn/ems4LD4wLHhvuySJyyaSw1h05H/v+kxR8ZZWxs+Nogdrlmd1pNvB0D8vCP8bbqMJFemJr+kiqUfK1XdF+Y4+uxL1o2WxugiKNs6epLEPR1MivQ0JYB+jMgApXxiGhK6D129o8pEM03Ra/RZR3972tw7fizGjUrnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0kbEzCCBCwfliZYSwakktJXjjge9xvLJvx1Yf2MNKE=;
 b=R35JsGIl4VyP4oNZvHK/ZYEnS16ZPpvAoucGYohyekYytG14pfu8+yFYxAjldC30hjkjjzX6EPFH7a98OOnXlTXyUkJuYhzCiJfwhZUTJyCLeBIXwsRJLi2QKJqjbQHD01r/zTL781Y011b/h4oqgRI4WzQholqwJXGBaThxgJg+fmWdFaSjZYGgjoOxrkdayZfQOpe52kGoH3mPv1OfPFnoQMss5+uPBoqgBUsoPuEPCtt82WRyCTmCeKzBiplbw0A69rAXcT93x4TMPveOvgJPuFrTVHwpoJ33x1Rq6msVhjlg4bnxXe0G487jaBB9H52D8nnag/3GI7fq4A+PDA==
Received: from SA1P222CA0093.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::18)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sat, 22 Feb
 2025 15:54:47 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::69) by SA1P222CA0093.outlook.office365.com
 (2603:10b6:806:35e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 15:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sat, 22 Feb 2025 15:54:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 22 Feb
 2025 07:54:32 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 22 Feb
 2025 07:54:31 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 22 Feb 2025 07:54:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 10/14] iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage
Date: Sat, 22 Feb 2025 07:54:07 -0800
Message-ID: <b5bb31a0a20ba2e8244840879f3268c3b5af81f8.1740238876.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740238876.git.nicolinc@nvidia.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 9960ee5b-7c5b-4f65-72a1-08dd53593b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?62hQaffom4e7DwRPDtn/Gjwih/cA0InP0x/wEGODWTebZNRMP+xpqQqTjvTh?=
 =?us-ascii?Q?/7/tzHkzbs2olyABf/BgQbY2s4SIzPC6hE549nKsmFONVcuv+lYYQ6p3d1Zt?=
 =?us-ascii?Q?ZIzIIaOto8ZrllTvYkjn9afBHLgsaCOXXPjAOl/EJfVgnWEekiFaD/3F4nMS?=
 =?us-ascii?Q?OSMu2Ucu7F/ftW8CrZeDR0ogzOvXBzStQ41AdmIet3nZF78mZgaqh0xtEi/B?=
 =?us-ascii?Q?NevstpiceD2AfWJ2GP5FC186vxsHQKbvCDvzpFE/vqHouN4yfoT4BoDv8aZG?=
 =?us-ascii?Q?txq47ErRwC46h604QM1TwrTHCem4IdXacgwImNNNrIV6odX9L6K5T/RAWY6x?=
 =?us-ascii?Q?W0Aot/3QD3NN41U1GksA19QT8MdYmFG7PAVXwoTDfaxTOLNp15Jn4Ecy3Bv6?=
 =?us-ascii?Q?hVMoiaTbty9JWWzk9/MAUvblKk59kQmHmxn/1I6nqlsFhiteDdmMZ4/8vfa0?=
 =?us-ascii?Q?lAN/5Towz+a4uc/2mBxQJn1fwGLTth+RwFXAakLGfVFtznWFzvso2dDVUQFU?=
 =?us-ascii?Q?8mbNosQK9TOlEG6tOMyQ/I2sLFvLCmUI/0CUM8UiNHyAES5Zr8GT3yztN11O?=
 =?us-ascii?Q?6xqKd7k9KCxLActryduDZvx1QvMRHl62QO5joHhZAF+2XicN3oKahce8nMRH?=
 =?us-ascii?Q?oyN2cq7m5BDSrG1O85pRU6YTcdENrrUGSga59kZOiVcPdfrBbkaNsVNJIU+1?=
 =?us-ascii?Q?tgNKKM6skrwG4/rmMXVQ29FxuiAc6y1DBh9NBI0pqnvMuFn2nsx2nvMF9SCU?=
 =?us-ascii?Q?dokSXbT+eLZl/pCieuyz4xNJGxPNhtzwHiptxYEi3QxxDbpSsSsBCkDhcMtU?=
 =?us-ascii?Q?bI8+8PO1/Ec/SzkpIJV67mPdkC/UQTYiFib+MVfZ4JSGAMBcM0qt98wEsXvf?=
 =?us-ascii?Q?TEbsw1fuQalM2ScXNyirLLm3ierMLMaYyO4nh4C0dxzvr5bG3mlvsv1kkBuk?=
 =?us-ascii?Q?zImzDKt+x0wUFcwsrj9TjgxdidTdXkkJ8utzGo/ZW0nstQn8xvWKzPSA3zOf?=
 =?us-ascii?Q?ERtes0m4kGSyiltY6IQSeKN5hrC7VVFHG7PDwB8SoIms4tdKSawhcSeJO9iX?=
 =?us-ascii?Q?zpQuS5bTtrAuSy+WTmtjjI96ryinc/ovUGhKMrVLoXI0mnp1VrWPw4nzHEMI?=
 =?us-ascii?Q?cEc46J4V73xBRVmEh/FBV986r5zQ1lz4BA47aBbI6P9HJXU4WFT17khcXzl0?=
 =?us-ascii?Q?5b8a5UlDhFOsHP2NsCBAWgxy9bEgdWW/lFDSl17QIyGjXEWtN1PliFLAPqW1?=
 =?us-ascii?Q?Mf1/bhBPnsgbtxSu4HpAdue5Vwc+vnY78FqJ5Mrpc8GDYPlrx6X4cwJHnyIF?=
 =?us-ascii?Q?WZYBGExfERtrUJGmLMWeDKdMMtl5YJ78f6bX/JYZ5A/jPywatEhpO5aJ5AAl?=
 =?us-ascii?Q?RQXkHwhr08dmu2MWiAZylS9ITg5Iq227dnEp6BX+6l6phTSPV+2b2Tll9COz?=
 =?us-ascii?Q?gB8rJ1vOK6zyzkXJyId2Ejjq6U6K1NVD0hmX8XhZJLeA2CQXPOKwql8Xl60+?=
 =?us-ascii?Q?ne9IsJHUtOBshoc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 15:54:46.8861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9960ee5b-7c5b-4f65-72a1-08dd53593b64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917

Trigger vEVENTs by feeding an idev ID and validating the returned output
virt_ids whether they equal to the value that was set to the vDEVICE.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd_utils.h | 115 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  31 +++++
 .../selftests/iommu/iommufd_fail_nth.c        |   7 ++
 3 files changed, 153 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index d979f5b0efe8..6f2ba2fa8f76 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -9,6 +9,7 @@
 #include <sys/ioctl.h>
 #include <stdint.h>
 #include <assert.h>
+#include <poll.h>
 
 #include "../kselftest_harness.h"
 #include "../../../../drivers/iommu/iommufd/iommufd_test.h"
@@ -936,3 +937,117 @@ static int _test_cmd_vdevice_alloc(int fd, __u32 viommu_id, __u32 idev_id,
 	EXPECT_ERRNO(_errno,                                                 \
 		     _test_cmd_vdevice_alloc(self->fd, viommu_id, idev_id,   \
 					     virt_id, vdev_id))
+
+static int _test_cmd_veventq_alloc(int fd, __u32 viommu_id, __u32 type,
+				   __u32 *veventq_id, __u32 *veventq_fd)
+{
+	struct iommu_veventq_alloc cmd = {
+		.size = sizeof(cmd),
+		.type = type,
+		.veventq_depth = 2,
+		.viommu_id = viommu_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VEVENTQ_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (veventq_id)
+		*veventq_id = cmd.out_veventq_id;
+	if (veventq_fd)
+		*veventq_fd = cmd.out_veventq_fd;
+	return 0;
+}
+
+#define test_cmd_veventq_alloc(viommu_id, type, veventq_id, veventq_fd) \
+	ASSERT_EQ(0, _test_cmd_veventq_alloc(self->fd, viommu_id, type, \
+					     veventq_id, veventq_fd))
+#define test_err_veventq_alloc(_errno, viommu_id, type, veventq_id,     \
+			       veventq_fd)                              \
+	EXPECT_ERRNO(_errno,                                            \
+		     _test_cmd_veventq_alloc(self->fd, viommu_id, type, \
+					     veventq_id, veventq_fd))
+
+static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
+{
+	struct iommu_test_cmd trigger_vevent_cmd = {
+		.size = sizeof(trigger_vevent_cmd),
+		.op = IOMMU_TEST_OP_TRIGGER_VEVENT,
+		.trigger_vevent = {
+			.dev_id = dev_id,
+		},
+	};
+	int ret;
+
+	while (nvevents--) {
+		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+			    &trigger_vevent_cmd);
+		if (ret < 0)
+			return -1;
+	}
+	return ret;
+}
+
+#define test_cmd_trigger_vevents(dev_id, nvevents) \
+	ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id, nvevents))
+
+static int _test_cmd_read_vevents(int fd, __u32 event_fd, __u32 nvevents,
+				  __u32 virt_id, int *prev_seq)
+{
+	struct pollfd pollfd = { .fd = event_fd, .events = POLLIN };
+	struct iommu_viommu_event_selftest *event;
+	struct iommufd_vevent_header *hdr;
+	ssize_t bytes;
+	void *data;
+	int ret, i;
+
+	ret = poll(&pollfd, 1, 1000);
+	if (ret < 0)
+		return -1;
+
+	data = calloc(nvevents, sizeof(*hdr) + sizeof(*event));
+	if (!data) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	bytes = read(event_fd, data,
+		     nvevents * (sizeof(*hdr) + sizeof(*event)));
+	if (bytes <= 0) {
+		errno = EFAULT;
+		ret = -1;
+		goto out_free;
+	}
+
+	for (i = 0; i < nvevents; i++) {
+		hdr = data + i * (sizeof(*hdr) + sizeof(*event));
+
+		if (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS ||
+		    hdr->sequence - *prev_seq > 1) {
+			*prev_seq = hdr->sequence;
+			errno = EOVERFLOW;
+			ret = -1;
+			goto out_free;
+		}
+		*prev_seq = hdr->sequence;
+		event = data + sizeof(*hdr);
+		if (event->virt_id != virt_id) {
+			errno = EINVAL;
+			ret = -1;
+			goto out_free;
+		}
+	}
+
+	ret = 0;
+out_free:
+	free(data);
+	return ret;
+}
+
+#define test_cmd_read_vevents(event_fd, nvevents, virt_id, prev_seq)      \
+	ASSERT_EQ(0, _test_cmd_read_vevents(self->fd, event_fd, nvevents, \
+					    virt_id, prev_seq))
+#define test_err_read_vevents(_errno, event_fd, nvevents, virt_id, prev_seq) \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_cmd_read_vevents(self->fd, event_fd, nvevents,    \
+					    virt_id, prev_seq))
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 212e5d62e13d..dd453aae8fed 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2774,15 +2774,46 @@ TEST_F(iommufd_viommu, vdevice_alloc)
 	uint32_t viommu_id = self->viommu_id;
 	uint32_t dev_id = self->device_id;
 	uint32_t vdev_id = 0;
+	uint32_t veventq_id;
+	uint32_t veventq_fd;
+	int prev_seq = -1;
 
 	if (dev_id) {
+		/* Must allocate vdevice before attaching to a nested hwpt */
+		test_err_mock_domain_replace(ENOENT, self->stdev_id,
+					     self->nested_hwpt_id);
+
+		/* Allocate a vEVENTQ with veventq_depth=2 */
+		test_cmd_veventq_alloc(viommu_id, IOMMU_VEVENTQ_TYPE_SELFTEST,
+				       &veventq_id, &veventq_fd);
+		test_err_veventq_alloc(EEXIST, viommu_id,
+				       IOMMU_VEVENTQ_TYPE_SELFTEST, NULL, NULL);
 		/* Set vdev_id to 0x99, unset it, and set to 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		test_cmd_trigger_vevents(dev_id, 1);
+		test_cmd_read_vevents(veventq_fd, 1, 0x99, &prev_seq);
 		test_err_vdevice_alloc(EEXIST, viommu_id, dev_id, 0x99,
 				       &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(vdev_id);
+
+		/* Try again with 0x88 */
 		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x88, &vdev_id);
+		test_cmd_mock_domain_replace(self->stdev_id,
+					     self->nested_hwpt_id);
+		/* Trigger an overflow with three events */
+		test_cmd_trigger_vevents(dev_id, 3);
+		test_err_read_vevents(EOVERFLOW, veventq_fd, 3, 0x88,
+				      &prev_seq);
+		/* Overflow must be gone after the previous reads */
+		test_cmd_trigger_vevents(dev_id, 1);
+		test_cmd_read_vevents(veventq_fd, 1, 0x88, &prev_seq);
+		close(veventq_fd);
+		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(vdev_id);
+		test_ioctl_destroy(veventq_id);
 	} else {
 		test_err_vdevice_alloc(ENOENT, viommu_id, dev_id, 0x99, NULL);
 	}
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 64b1f8e1b0cf..99a7f7897bb2 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -620,6 +620,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	};
 	struct iommu_test_hw_info info;
 	uint32_t fault_id, fault_fd;
+	uint32_t veventq_id, veventq_fd;
 	uint32_t fault_hwpt_id;
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
@@ -692,6 +693,12 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 				 IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data)))
 		return -1;
 
+	if (_test_cmd_veventq_alloc(self->fd, viommu_id,
+				    IOMMU_VEVENTQ_TYPE_SELFTEST, &veventq_id,
+				    &veventq_fd))
+		return -1;
+	close(veventq_fd);
+
 	return 0;
 }
 
-- 
2.43.0


