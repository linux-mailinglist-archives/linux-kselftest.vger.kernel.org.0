Return-Path: <linux-kselftest+bounces-46121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DFEC746F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id AB6772B3DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F130346FC0;
	Thu, 20 Nov 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="S6AH/fUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CA33DEEE;
	Thu, 20 Nov 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647587; cv=none; b=fexCuW3j3gUoIXVoa8hAao7Y52l4Mq7Nbumjm2hufsTNgSyufuXpv3Js5K0bJNiyrpkdcrblEr/hJliudfiLwpA8NTaG9T2n1csXeLb6odvnskj3kuUrum3e4qT8SMGmi+3DDCKzcPsBpJiYF2f/2ZuzLsWk+P+t4+74K4y0wKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647587; c=relaxed/simple;
	bh=bkqgvuu6ZDi4m8OZt47kYAboBnOXfr5oEW9H99FRf0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0iGDIM65GoSJBJdU7vy5cSKu8innBM+IqCSUDkOqRn9nvTJAxomVcP6+an590JyISz8Bogv9DBqr8cs7k0lJJ90fVS5Jvc6gePoN87Z99sHMDX02SOV+m7myQLX6RQAf9jXVhsHyuspPT5jLjvJAbyKbJWj2eNaahArSlJ5O8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=S6AH/fUj; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647585; x=1795183585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hW4y4zBjWTdGm6aMhKcrQThGFKEb24CVLQU1+YqnkPM=;
  b=S6AH/fUj5akgeYx8TCtgASTFYlokW3sbyxqrHIn4D8qsX5k0WwaSZjrq
   OoMZlyFS7lN50WCgVjyfWUUa8DrKwLjW/UgFPaj3iR7ZXAZ5BVsu55u7u
   uvL11T9ILO2RV3Y+uy6zLFPNv0Dq37W53PU2Nqsrn0hp0GEc3JJerzIIq
   F1/su466+Fvi4iVQ4JsdrjWxbn+9/+7tgLEPa9L+sdAFxuNhuGDEaibSR
   E/c2hEvBTaHQitVd45TMNUlJxG7B3U4RcnVsTZUMgd4LuXveVyeJdcMeK
   B4gM2YDPjtp+wQWvmXu/NNVWyz8ookqMKJXDeWC13+Dhzhw2qCcB+g/1O
   w==;
X-CSE-ConnectionGUID: +QfcMLEcSz+q3uRqacJEEg==
X-CSE-MsgGUID: AcNYnBl5QQiEDCuh3GieEQ==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="7439719"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:06:22 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:22543]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.241:2525] with esmtp (Farcaster)
 id 1ad7e3c3-7b94-4ee4-981d-7188293d96db; Thu, 20 Nov 2025 14:06:22 +0000 (UTC)
X-Farcaster-Flow-ID: 1ad7e3c3-7b94-4ee4-981d-7188293d96db
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:06:21 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:06:18 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 12/13] KVM: arm64: selftests: Add support for stress testing direct-injected vLPIs
Date: Thu, 20 Nov 2025 15:03:01 +0100
Message-ID: <20251120140305.63515-13-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

vgic_lpi_stress stress tests LPIs by injecting MSIs to a guest's GIC.
Since these MSIs are purely defined in userspace, they are handled as
LPIs by the hypervisor as software interrupts.

We provide two ways to stress test direct-injected vLPIs.
-    When per-vCPU vLPI injection is disabled, use -D flag to upgrade
     all LPIs fired by the stress test to vLPIs. This flag mocks a
     host_irq for each MSI and calls KVM_DEBUG_GIC_MSI_SETUP to create
     and map vITS data structures needed for direct injection.
-    When per-vCPU vLPI injection is enabled, use -s flag to pass
     per-vCPU command strings to control the state of vPE initialization
     on each vCPU throughout the test. Allows stress testing vLPI
     injection on partially-enabled VMs.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.de>
---
 .../selftests/kvm/arm64/vgic_lpi_stress.c     | 181 +++++++++++++++++-
 1 file changed, 177 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
index e857a605f577..b3fe5fdf4285 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_lpi_stress.c
@@ -18,9 +18,17 @@
 #include "ucall.h"
 #include "vgic.h"
 
+#define KVM_DEBUG_GIC_MSI_SETUP    _IOW(KVMIO, 0xf3, struct kvm_debug_gic_msi_setup)
+
 #define TEST_MEMSLOT_INDEX	1
 
 #define GIC_LPI_OFFSET	8192
+#define SPI_IRQ_RANGE_OFFSET 32
+
+static bool vlpi_enabled;
+static bool string_mode;
+static char **vcpu_strings;
+static bool *vcpu_enabled;
 
 static size_t nr_iterations = 1000;
 static vm_paddr_t gpa_base;
@@ -222,6 +230,79 @@ static void setup_gic(void)
 	its_fd = vgic_its_setup(vm);
 }
 
+static int enable_msi_vlpi_injection(u32 device_id, u32 event_id,
+		u32 vcpu_id, u32 vintid, u32 host_irq)
+{
+	struct kvm_debug_gic_msi_setup params = {
+		.device_id	= device_id,
+		.event_id	= event_id,
+		.vcpu_id	= vcpu_id,
+		.vintid		= vintid,
+		.host_irq	= host_irq,
+		.itt_addr	= test_data.itt_tables + (device_id * SZ_64K)
+	};
+
+	return __vm_ioctl(vm, KVM_DEBUG_GIC_MSI_SETUP, &params);
+}
+
+static void upgrade_vcpu_lpis(struct kvm_vcpu *vcpu)
+{
+	u32 intid = GIC_LPI_OFFSET;
+	u32 target_vcpu = 0; /* Start round-robin from vCPU 0 */
+	u32 device_id, event_id;
+
+	for (device_id = 0; device_id < test_data.nr_devices; device_id++) {
+		for (event_id = 0; event_id < test_data.nr_event_ids;
+		     event_id++) {
+			/*
+			 * Only setup vLPI mapping if this is the target vCPU
+			 * for this interrupt
+			 */
+			if (target_vcpu == vcpu->id) {
+				/*
+				 * we mock host_irqs in the SPI interrupt range
+				 * of 100-1020 since selftest guests have no
+				 * hardware devices
+				 */
+				int ret = enable_msi_vlpi_injection(device_id,
+					event_id, vcpu->id, intid,
+					intid - GIC_LPI_OFFSET + SPI_IRQ_RANGE_OFFSET);
+
+				if (ret == -ENXIO || ret == -1) {
+					pr_info("Direct vLPI injection is disabled for vCPU %d, defaulting to software LPI handling\n",
+						vcpu->id);
+					return;
+				}
+				TEST_ASSERT(ret == 0,
+					    "KVM_DEBUG_GIC_MSI_SETUP failed: %d\n",
+					    ret);
+			}
+
+			intid++;
+			target_vcpu = (target_vcpu + 1) % test_data.nr_cpus;
+		}
+	}
+}
+
+
+
+static void enable_vcpu_vlpi_injection(int vcpu_id)
+{
+	int ret = ioctl(vm->fd, KVM_ENABLE_VCPU_VLPI, &vcpu_id);
+
+	TEST_ASSERT(ret == 0, "KVM_ENABLE_VCPU_VLPI failed: %d", ret);
+	pr_info("Enabled vLPI injection on vCPU %d\n", vcpu_id);
+	upgrade_vcpu_lpis(vcpus[vcpu_id]);
+}
+
+static void disable_vcpu_vlpi_injection(int vcpu_id)
+{
+	int ret = ioctl(vm->fd, KVM_DISABLE_VCPU_VLPI, &vcpu_id);
+
+	TEST_ASSERT(ret == 0, "KVM_DISABLE_VCPU_VLPI failed: %d", ret);
+	pr_info("Disabled vLPI injection on vCPU %d\n", vcpu_id);
+}
+
 static void signal_lpi(u32 device_id, u32 event_id)
 {
 	vm_paddr_t db_addr = GITS_BASE_GPA + GITS_TRANSLATER;
@@ -243,18 +324,36 @@ static void signal_lpi(u32 device_id, u32 event_id)
 }
 
 static pthread_barrier_t test_setup_barrier;
+static pthread_barrier_t vlpi_upgrade_barrier;
 
 static void *lpi_worker_thread(void *data)
 {
 	u32 device_id = (size_t)data;
 	u32 event_id;
 	size_t i;
+	int vcpu_id;
 
 	pthread_barrier_wait(&test_setup_barrier);
-
-	for (i = 0; i < nr_iterations; i++)
+	pthread_barrier_wait(&vlpi_upgrade_barrier);
+
+	for (i = 0; i < nr_iterations; i++) {
+		/* conduct per-vCPU vLPI enablement/disablement */
+		if (string_mode) {
+			for (vcpu_id = 0; vcpu_id < test_data.nr_cpus; vcpu_id++) {
+				char action = vcpu_strings[vcpu_id][i];
+
+				if (action == 'e' && !vcpu_enabled[vcpu_id]) {
+					enable_vcpu_vlpi_injection(vcpu_id);
+					vcpu_enabled[vcpu_id] = true;
+				} else if (action == 'd' && vcpu_enabled[vcpu_id]) {
+					disable_vcpu_vlpi_injection(vcpu_id);
+					vcpu_enabled[vcpu_id] = false;
+				}
+			}
+		}
 		for (event_id = 0; event_id < test_data.nr_event_ids; event_id++)
 			signal_lpi(device_id, event_id);
+	}
 
 	return NULL;
 }
@@ -270,6 +369,10 @@ static void *vcpu_worker_thread(void *data)
 		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_SYNC:
 			pthread_barrier_wait(&test_setup_barrier);
+			/* if flag is set, set direct injection mappings for MSIs */
+			if (vlpi_enabled)
+				upgrade_vcpu_lpis(vcpu);
+			pthread_barrier_wait(&vlpi_upgrade_barrier);
 			continue;
 		case UCALL_DONE:
 			return NULL;
@@ -309,6 +412,7 @@ static void run_test(void)
 	TEST_ASSERT(lpi_threads && vcpu_threads, "Failed to allocate pthread arrays");
 
 	pthread_barrier_init(&test_setup_barrier, NULL, nr_vcpus + nr_devices + 1);
+	pthread_barrier_init(&vlpi_upgrade_barrier, NULL, nr_vcpus + nr_devices + 1);
 
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_create(&vcpu_threads[i], NULL, vcpu_worker_thread, vcpus[i]);
@@ -317,6 +421,7 @@ static void run_test(void)
 		pthread_create(&lpi_threads[i], NULL, lpi_worker_thread, (void *)i);
 
 	pthread_barrier_wait(&test_setup_barrier);
+	pthread_barrier_wait(&vlpi_upgrade_barrier);  /* Wait for all vLPI upgrades */
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 
@@ -361,13 +466,71 @@ static void destroy_vm(void)
 	free(vcpus);
 }
 
+static int parse_vcpu_strings(const char *str)
+{
+	char *token, *saveptr, *str_copy;
+	int count = 0, len = -1, i;
+
+	str_copy = strdup(str);
+	TEST_ASSERT(str_copy, "Failed to allocate string copy");
+
+	token = strtok_r(str_copy, ",", &saveptr);
+	while (token) {
+		count++;
+		token = strtok_r(NULL, ",", &saveptr);
+	}
+	free(str_copy);
+
+	vcpu_strings = malloc(count * sizeof(char *));
+	vcpu_enabled = calloc(count, sizeof(bool));
+	TEST_ASSERT(vcpu_strings && vcpu_enabled, "Failed to allocate arrays");
+
+	str_copy = strdup(str);
+	token = strtok_r(str_copy, ",", &saveptr);
+	for (i = 0; i < count; i++) {
+		int token_len = strlen(token);
+
+		if (len == -1)
+			len = token_len;
+		else if (len != token_len)
+			TEST_FAIL("All strings must have same length");
+
+		TEST_ASSERT(len > 0, "Strings cannot be empty");
+
+		for (int j = 0; j < token_len; j++)
+			if (token[j] != 'd' && token[j] != 'e')
+				TEST_FAIL("Strings can only contain 'd' and 'e'");
+
+		vcpu_strings[i] = strdup(token);
+		TEST_ASSERT(vcpu_strings[i], "Failed to allocate string");
+		token = strtok_r(NULL, ",", &saveptr);
+	}
+	free(str_copy);
+
+	test_data.nr_cpus = count;
+	test_data.nr_devices = 1;
+	test_data.nr_event_ids = count;
+	nr_iterations = len;
+
+	return 0;
+}
+
 static void pr_usage(const char *name)
 {
-	pr_info("%s [-v NR_VCPUS] [-d NR_DEVICES] [-e NR_EVENTS] [-i ITERS] -h\n", name);
+	pr_info("%s -D [-v NR_VCPUS] [-d NR_DEVICES] [-e NR_EVENTS] [-i ITERS] | -s STRINGS -h\n",
+		name);
+	pr_info("  -D:\tenable direct vLPI injection (default: %s)\n",
+			vlpi_enabled ? "true" : "false");
 	pr_info("  -v:\tnumber of vCPUs (default: %u)\n", test_data.nr_cpus);
 	pr_info("  -d:\tnumber of devices (default: %u)\n", test_data.nr_devices);
 	pr_info("  -e:\tnumber of event IDs per device (default: %u)\n", test_data.nr_event_ids);
 	pr_info("  -i:\tnumber of iterations (default: %lu)\n", nr_iterations);
+	pr_info("  -s:\tvCPU control strings (comma-separated, e.g., \"dede,eede\"),\n");
+	pr_info("     \twhere each string corresponds to the per-iteration vLPI status\n");
+	pr_info("     \tof a single vCPU. \"ddeed\" means a vCPU will be vLPI-disabled for two\n");
+	pr_info("     \titerations, enabled for two iterations, then disabled for one iteration.\n");
+	pr_info("     \tNumber of strings corresponds to the number of vCPUs, and all strings must\n");
+	pr_info("     \tbe of the same size. Cannot be used in conjunction with other flags.\n");
 }
 
 int main(int argc, char **argv)
@@ -377,8 +540,11 @@ int main(int argc, char **argv)
 
 	TEST_REQUIRE(kvm_supports_vgic_v3());
 
-	while ((c = getopt(argc, argv, "hv:d:e:i:")) != -1) {
+	while ((c = getopt(argc, argv, "hDv:d:e:i:s:")) != -1) {
 		switch (c) {
+		case 'D':
+			vlpi_enabled = true;
+			break;
 		case 'v':
 			test_data.nr_cpus = atoi(optarg);
 			break;
@@ -391,6 +557,10 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_iterations = strtoul(optarg, NULL, 0);
 			break;
+		case 's':
+			string_mode = true;
+			parse_vcpu_strings(optarg);
+			break;
 		case 'h':
 		default:
 			pr_usage(argv[0]);
@@ -398,6 +568,9 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (string_mode && argc > 3)
+		TEST_FAIL("-s cannot be used with other flags");
+
 	nr_threads = test_data.nr_cpus + test_data.nr_devices;
 	if (nr_threads > get_nprocs())
 		pr_info("WARNING: running %u threads on %d CPUs; performance is degraded.\n",
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


