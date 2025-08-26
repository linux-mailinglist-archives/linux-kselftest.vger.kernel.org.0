Return-Path: <linux-kselftest+bounces-39944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1AB35F4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 14:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF061BA2FD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27792341655;
	Tue, 26 Aug 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL9SCld0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A232143C;
	Tue, 26 Aug 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211999; cv=none; b=Ek4i9vSRemWocm9UdO20E/bJ0WWNdx0o51OEDNbPsVXYg5JiXLb/umsrSKa+b0zjydZAyR1oqCwzo7I10KieBAmP6yIFRkKVfWi8Pc5nkur+2QP/n6T6o/zL138H2ooqV967blnpIh6DONe+egzsgLbxL6e8xzWGz4M9PQHQoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211999; c=relaxed/simple;
	bh=uOAylKK8VYjOuoqIUOqP7NlLxP9wcPLBaaHlAl3e/N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npM9kt3AMUpCJiYqs8nJRv7xfxT25CYMS98hOFHt/9ba4jpro5rWUNnPdD6+VGHeK/ZNLJ1JO/wRgFtJv9oGe0tcu/ND2j7vGHj7GFn9nilBymdpwlo5bPZ8S9g3Iru/okwsIp3944E3TE+k815b/YjV+aW5np9CDtVQFyF8A74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL9SCld0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9047CC19423;
	Tue, 26 Aug 2025 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756211996;
	bh=uOAylKK8VYjOuoqIUOqP7NlLxP9wcPLBaaHlAl3e/N8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KL9SCld0w0YEcXlkPAAv3S+rvwsHjMXqw+E8QcTx+7aiZ+Zqzzg+MwuuVsrwVgiJt
	 zAGl/+mWjRUeNVx9YISSRjJWIKx6iPF+pJrTi+GrDPJtsYzeOQV18piCnQhIbovNz2
	 P4K2xgdh/CAt0le+9vbhKVjTDwbMwXbQJWvcKIYTbr9fa4+bnCz4ABvZCM/3Sy8+ND
	 PG6dGI53919QL935OxCri/3zEFqiDYM39JUmFWjYtJHQ8SS4+F+Ba/0yc8xNPB1qB5
	 6qXbwITSBBFIBpWvFOtqiXYsGjHv/+ST3NbgUj7w9oxskY3wHm3Vv+HZsEpmnQxL1N
	 LGyQ2ywVODifg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 26 Aug 2025 14:39:39 +0200
Subject: [PATCH v2 1/3] selftests/hid: hidraw: add more coverage for hidraw
 ioctls
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-b4-hidraw-ioctls-v2-1-c7726b236719@kernel.org>
References: <20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org>
In-Reply-To: <20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756211993; l=11713;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=uOAylKK8VYjOuoqIUOqP7NlLxP9wcPLBaaHlAl3e/N8=;
 b=g+S3obILI/Av7Zyapl2lmKuHNKUfnmkpHxZ9P8nyPbBMZ9Oqd1yiXWHWyv1AgMdvHU9uS/HDy
 4qE3TKfDog6APJEGWPlzOfASWIii0tKQgEl0IqLvTb88roIBO4T1snX
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Try to ensure all ioctls are having at least one test.

Co-developed-by: claude-4-sonnet
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_common.h |   6 +
 tools/testing/selftests/hid/hidraw.c     | 346 +++++++++++++++++++++++++++++++
 2 files changed, 352 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_common.h b/tools/testing/selftests/hid/hid_common.h
index f77f69c6657d0f0f66beb3b50bf4b126f6f63348..8085519c47cb505b901ac80f2087dc9a1aa2b9c0 100644
--- a/tools/testing/selftests/hid/hid_common.h
+++ b/tools/testing/selftests/hid/hid_common.h
@@ -230,6 +230,12 @@ static int uhid_event(struct __test_metadata *_metadata, int fd)
 		break;
 	case UHID_SET_REPORT:
 		UHID_LOG("UHID_SET_REPORT from uhid-dev");
+
+		answer.type = UHID_SET_REPORT_REPLY;
+		answer.u.set_report_reply.id = ev.u.set_report.id;
+		answer.u.set_report_reply.err = 0; /* success */
+
+		uhid_write(_metadata, fd, &answer);
 		break;
 	default:
 		TH_LOG("Invalid event from uhid-dev: %u", ev.type);
diff --git a/tools/testing/selftests/hid/hidraw.c b/tools/testing/selftests/hid/hidraw.c
index 821db37ba4bbef82e5cf4b44b6675666f87a12ad..6d61d03e2ef05e1900fe5a3938d93421717b2621 100644
--- a/tools/testing/selftests/hid/hidraw.c
+++ b/tools/testing/selftests/hid/hidraw.c
@@ -2,6 +2,9 @@
 /* Copyright (c) 2022-2024 Red Hat */
 
 #include "hid_common.h"
+#include <linux/input.h>
+#include <string.h>
+#include <sys/ioctl.h>
 
 /* for older kernels */
 #ifndef HIDIOCREVOKE
@@ -215,6 +218,349 @@ TEST_F(hidraw, write_event_revoked)
 	pthread_mutex_unlock(&uhid_output_mtx);
 }
 
+/*
+ * Test HIDIOCGRDESCSIZE ioctl to get report descriptor size
+ */
+TEST_F(hidraw, ioctl_rdescsize)
+{
+	int desc_size = 0;
+	int err;
+
+	/* call HIDIOCGRDESCSIZE ioctl */
+	err = ioctl(self->hidraw_fd, HIDIOCGRDESCSIZE, &desc_size);
+	ASSERT_EQ(err, 0) TH_LOG("HIDIOCGRDESCSIZE ioctl failed");
+
+	/* verify the size matches our test report descriptor */
+	ASSERT_EQ(desc_size, sizeof(rdesc))
+		TH_LOG("expected size %zu, got %d", sizeof(rdesc), desc_size);
+}
+
+/*
+ * Test HIDIOCGRDESC ioctl to get report descriptor data
+ */
+TEST_F(hidraw, ioctl_rdesc)
+{
+	struct hidraw_report_descriptor desc;
+	int err;
+
+	/* get the full report descriptor */
+	desc.size = sizeof(rdesc);
+	err = ioctl(self->hidraw_fd, HIDIOCGRDESC, &desc);
+	ASSERT_EQ(err, 0) TH_LOG("HIDIOCGRDESC ioctl failed");
+
+	/* verify the descriptor data matches our test descriptor */
+	ASSERT_EQ(memcmp(desc.value, rdesc, sizeof(rdesc)), 0)
+		TH_LOG("report descriptor data mismatch");
+}
+
+/*
+ * Test HIDIOCGRDESC ioctl with smaller buffer size
+ */
+TEST_F(hidraw, ioctl_rdesc_small_buffer)
+{
+	struct hidraw_report_descriptor desc;
+	int err;
+	size_t small_size = sizeof(rdesc) / 2; /* request half the descriptor size */
+
+	/* get partial report descriptor */
+	desc.size = small_size;
+	err = ioctl(self->hidraw_fd, HIDIOCGRDESC, &desc);
+	ASSERT_EQ(err, 0) TH_LOG("HIDIOCGRDESC ioctl failed with small buffer");
+
+	/* verify we got the first part of the descriptor */
+	ASSERT_EQ(memcmp(desc.value, rdesc, small_size), 0)
+		TH_LOG("partial report descriptor data mismatch");
+}
+
+/*
+ * Test HIDIOCGRAWINFO ioctl to get device information
+ */
+TEST_F(hidraw, ioctl_rawinfo)
+{
+	struct hidraw_devinfo devinfo;
+	int err;
+
+	/* get device info */
+	err = ioctl(self->hidraw_fd, HIDIOCGRAWINFO, &devinfo);
+	ASSERT_EQ(err, 0) TH_LOG("HIDIOCGRAWINFO ioctl failed");
+
+	/* verify device info matches our test setup */
+	ASSERT_EQ(devinfo.bustype, BUS_USB)
+		TH_LOG("expected bustype 0x03, got 0x%x", devinfo.bustype);
+	ASSERT_EQ(devinfo.vendor, 0x0001)
+		TH_LOG("expected vendor 0x0001, got 0x%x", devinfo.vendor);
+	ASSERT_EQ(devinfo.product, 0x0a37)
+		TH_LOG("expected product 0x0a37, got 0x%x", devinfo.product);
+}
+
+/*
+ * Test HIDIOCGFEATURE ioctl to get feature report
+ */
+TEST_F(hidraw, ioctl_gfeature)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* set report ID 1 in first byte */
+	buf[0] = 1;
+
+	/* get feature report */
+	err = ioctl(self->hidraw_fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	ASSERT_EQ(err, sizeof(feature_data)) TH_LOG("HIDIOCGFEATURE ioctl failed, got %d", err);
+
+	/* verify we got the expected feature data */
+	ASSERT_EQ(buf[0], feature_data[0])
+		TH_LOG("expected feature_data[0] = %d, got %d", feature_data[0], buf[0]);
+	ASSERT_EQ(buf[1], feature_data[1])
+		TH_LOG("expected feature_data[1] = %d, got %d", feature_data[1], buf[1]);
+}
+
+/*
+ * Test HIDIOCGFEATURE ioctl with invalid report ID
+ */
+TEST_F(hidraw, ioctl_gfeature_invalid)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* set invalid report ID (not 1) */
+	buf[0] = 2;
+
+	/* try to get feature report */
+	err = ioctl(self->hidraw_fd, HIDIOCGFEATURE(sizeof(buf)), buf);
+	ASSERT_LT(err, 0) TH_LOG("HIDIOCGFEATURE should have failed with invalid report ID");
+	ASSERT_EQ(errno, EIO) TH_LOG("expected EIO, got errno %d", errno);
+}
+
+/*
+ * Test HIDIOCSFEATURE ioctl to set feature report
+ */
+TEST_F(hidraw, ioctl_sfeature)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* prepare feature report data */
+	buf[0] = 1; /* report ID */
+	buf[1] = 0x42;
+	buf[2] = 0x24;
+
+	/* set feature report */
+	err = ioctl(self->hidraw_fd, HIDIOCSFEATURE(3), buf);
+	ASSERT_EQ(err, 3) TH_LOG("HIDIOCSFEATURE ioctl failed, got %d", err);
+
+	/*
+	 * Note: The uhid mock doesn't validate the set report data,
+	 * so we just verify the ioctl succeeds
+	 */
+}
+
+/*
+ * Test HIDIOCGINPUT ioctl to get input report
+ */
+TEST_F(hidraw, ioctl_ginput)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* set report ID 1 in first byte */
+	buf[0] = 1;
+
+	/* get input report */
+	err = ioctl(self->hidraw_fd, HIDIOCGINPUT(sizeof(buf)), buf);
+	ASSERT_EQ(err, sizeof(feature_data)) TH_LOG("HIDIOCGINPUT ioctl failed, got %d", err);
+
+	/* verify we got the expected input data */
+	ASSERT_EQ(buf[0], feature_data[0])
+		TH_LOG("expected feature_data[0] = %d, got %d", feature_data[0], buf[0]);
+	ASSERT_EQ(buf[1], feature_data[1])
+		TH_LOG("expected feature_data[1] = %d, got %d", feature_data[1], buf[1]);
+}
+
+/*
+ * Test HIDIOCGINPUT ioctl with invalid report ID
+ */
+TEST_F(hidraw, ioctl_ginput_invalid)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* set invalid report ID (not 1) */
+	buf[0] = 2;
+
+	/* try to get input report */
+	err = ioctl(self->hidraw_fd, HIDIOCGINPUT(sizeof(buf)), buf);
+	ASSERT_LT(err, 0) TH_LOG("HIDIOCGINPUT should have failed with invalid report ID");
+	ASSERT_EQ(errno, EIO) TH_LOG("expected EIO, got errno %d", errno);
+}
+
+/*
+ * Test HIDIOCSINPUT ioctl to set input report
+ */
+TEST_F(hidraw, ioctl_sinput)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* prepare input report data */
+	buf[0] = 1; /* report ID */
+	buf[1] = 0x55;
+	buf[2] = 0xAA;
+
+	/* set input report */
+	err = ioctl(self->hidraw_fd, HIDIOCSINPUT(3), buf);
+	ASSERT_EQ(err, 3) TH_LOG("HIDIOCSINPUT ioctl failed, got %d", err);
+
+	/*
+	 * Note: The uhid mock doesn't validate the set report data,
+	 * so we just verify the ioctl succeeds
+	 */
+}
+
+/*
+ * Test HIDIOCGOUTPUT ioctl to get output report
+ */
+TEST_F(hidraw, ioctl_goutput)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* set report ID 1 in first byte */
+	buf[0] = 1;
+
+	/* get output report */
+	err = ioctl(self->hidraw_fd, HIDIOCGOUTPUT(sizeof(buf)), buf);
+	ASSERT_EQ(err, sizeof(feature_data)) TH_LOG("HIDIOCGOUTPUT ioctl failed, got %d", err);
+
+	/* verify we got the expected output data */
+	ASSERT_EQ(buf[0], feature_data[0])
+		TH_LOG("expected feature_data[0] = %d, got %d", feature_data[0], buf[0]);
+	ASSERT_EQ(buf[1], feature_data[1])
+		TH_LOG("expected feature_data[1] = %d, got %d", feature_data[1], buf[1]);
+}
+
+/*
+ * Test HIDIOCGOUTPUT ioctl with invalid report ID
+ */
+TEST_F(hidraw, ioctl_goutput_invalid)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* set invalid report ID (not 1) */
+	buf[0] = 2;
+
+	/* try to get output report */
+	err = ioctl(self->hidraw_fd, HIDIOCGOUTPUT(sizeof(buf)), buf);
+	ASSERT_LT(err, 0) TH_LOG("HIDIOCGOUTPUT should have failed with invalid report ID");
+	ASSERT_EQ(errno, EIO) TH_LOG("expected EIO, got errno %d", errno);
+}
+
+/*
+ * Test HIDIOCSOUTPUT ioctl to set output report
+ */
+TEST_F(hidraw, ioctl_soutput)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* prepare output report data */
+	buf[0] = 1; /* report ID */
+	buf[1] = 0x33;
+	buf[2] = 0xCC;
+
+	/* set output report */
+	err = ioctl(self->hidraw_fd, HIDIOCSOUTPUT(3), buf);
+	ASSERT_EQ(err, 3) TH_LOG("HIDIOCSOUTPUT ioctl failed, got %d", err);
+
+	/*
+	 * Note: The uhid mock doesn't validate the set report data,
+	 * so we just verify the ioctl succeeds
+	 */
+}
+
+/*
+ * Test HIDIOCGRAWNAME ioctl to get device name string
+ */
+TEST_F(hidraw, ioctl_rawname)
+{
+	char name[256] = {0};
+	char expected_name[64];
+	int err;
+
+	/* get device name */
+	err = ioctl(self->hidraw_fd, HIDIOCGRAWNAME(sizeof(name)), name);
+	ASSERT_GT(err, 0) TH_LOG("HIDIOCGRAWNAME ioctl failed, got %d", err);
+
+	/* construct expected name based on device id */
+	snprintf(expected_name, sizeof(expected_name), "test-uhid-device-%d", self->hid.dev_id);
+
+	/* verify the name matches expected pattern */
+	ASSERT_EQ(strcmp(name, expected_name), 0)
+		TH_LOG("expected name '%s', got '%s'", expected_name, name);
+}
+
+/*
+ * Test HIDIOCGRAWPHYS ioctl to get device physical address string
+ */
+TEST_F(hidraw, ioctl_rawphys)
+{
+	char phys[256] = {0};
+	char expected_phys[64];
+	int err;
+
+	/* get device physical address */
+	err = ioctl(self->hidraw_fd, HIDIOCGRAWPHYS(sizeof(phys)), phys);
+	ASSERT_GT(err, 0) TH_LOG("HIDIOCGRAWPHYS ioctl failed, got %d", err);
+
+	/* construct expected phys based on device id */
+	snprintf(expected_phys, sizeof(expected_phys), "%d", self->hid.dev_id);
+
+	/* verify the phys matches expected value */
+	ASSERT_EQ(strcmp(phys, expected_phys), 0)
+		TH_LOG("expected phys '%s', got '%s'", expected_phys, phys);
+}
+
+/*
+ * Test HIDIOCGRAWUNIQ ioctl to get device unique identifier string
+ */
+TEST_F(hidraw, ioctl_rawuniq)
+{
+	char uniq[256] = {0};
+	int err;
+
+	/* get device unique identifier */
+	err = ioctl(self->hidraw_fd, HIDIOCGRAWUNIQ(sizeof(uniq)), uniq);
+	ASSERT_GE(err, 0) TH_LOG("HIDIOCGRAWUNIQ ioctl failed, got %d", err);
+
+	/* uniq is typically empty in our test setup */
+	ASSERT_EQ(strlen(uniq), 0) TH_LOG("expected empty uniq, got '%s'", uniq);
+}
+
+/*
+ * Test device string ioctls with small buffer sizes
+ */
+TEST_F(hidraw, ioctl_strings_small_buffer)
+{
+	char small_buf[8] = {0};
+	char expected_name[64];
+	int err;
+
+	/* test HIDIOCGRAWNAME with small buffer */
+	err = ioctl(self->hidraw_fd, HIDIOCGRAWNAME(sizeof(small_buf)), small_buf);
+	ASSERT_EQ(err, sizeof(small_buf))
+		TH_LOG("HIDIOCGRAWNAME with small buffer failed, got %d", err);
+
+	/* construct expected truncated name */
+	snprintf(expected_name, sizeof(expected_name), "test-uhid-device-%d", self->hid.dev_id);
+
+	/* verify we got truncated name (first 8 chars, no null terminator guaranteed) */
+	ASSERT_EQ(strncmp(small_buf, expected_name, sizeof(small_buf)), 0)
+		TH_LOG("expected truncated name to match first %zu chars", sizeof(small_buf));
+
+	/* Note: hidraw driver doesn't guarantee null termination when buffer is too small */
+}
+
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);

-- 
2.51.0


