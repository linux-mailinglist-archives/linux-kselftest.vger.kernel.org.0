Return-Path: <linux-kselftest+bounces-17701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16A9746F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7675D288BA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175471C462D;
	Tue, 10 Sep 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAZyB3D8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317471C460D
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011942; cv=none; b=Bo/wiqdRdzjYQ6TDZVr6cbrCfIjCBp99oVy1EH3Z9l3xKVdrAHv/y4cgJfxF1AKP55yhvn/z74v6HXseluwOhBEPJwKRm2PBIoqewoW67Sa4sI1yFADSDj67+vuTn4gZnVEytMmAwVTFlGNqi709RfeXZJUS0tCwP+EI7awdDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011942; c=relaxed/simple;
	bh=lSgzKR2zgY1yuRxZGAYxWOGW/nuOArA+zW0Hd0c2OlE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UDjrrYVaIn02FXjx7ylQi1VkGrsuDAxA8iQgGdyYc89m5TsymC4YIAeEzwgI9K1kqLRrq0Y5WbWPx6ImYP5scPDNqsjZAC/8riBJNV8u6CukIScZYOIvm+LazWdtp3xXY1Jv+aO/t8x7IdnMewipEUdPkQ2gZHDqxDRg0lQmbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pAZyB3D8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d73dd8ac65so183570967b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011939; x=1726616739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlIOiJjV6U0PI3iCsuHTa2oFdtPEU4Vo6B5xI+1eOyo=;
        b=pAZyB3D8Zvfm3cBCopZr51wJkfi1KIiCSdrD4erGAkN0tCjq84BU0dlEGGYZkwIen7
         RkJh86AzHpv21Y8la+nNCxTVfSnCu9NPCFzGiTnNo8v+340PoVCjK+fUOFmWqb+2sBWO
         TZ+kCvKFopiEbDLJ/+2BaXDnDF33SwFbDAnyi4r7XMN7ZJprhNoNx0ahyiKmNlkPkY5n
         tuaDkdbagWhCzwBdw4rApnvhvHuEPPAmv8ZV7C+uDWoFIdyP7GgKWNom7SDXmrWf1awF
         B+bOPG6DDdzWxINgbjRjJnkHgaID1Z+8+MbRySwCiS3udHbg8DwOqY83BdEeIT5SJiC6
         rvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011939; x=1726616739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlIOiJjV6U0PI3iCsuHTa2oFdtPEU4Vo6B5xI+1eOyo=;
        b=aLK/SOWn2aNpaxwK6jzrdkmgBQpAJyUhxyS33eSchxkvHPDEc3lfzsmo3m6hvRKJke
         xw4CbCIVME4Ifyr/4l2rOz2c2JhaYz3oGKYpkTjtXLVUnGOGc9LpoeLEacf7EmppHIhP
         Tl0f3I4ES6KdmyxfACuQvV85FPzoUz87pG+UAWcnW/bu9raUAHQDiOb/58Uhofmzo6Ug
         3mrFeASD+7humMp+GuteorU8AS+xOQIkawBUJfWAzpzPzuoufHRQWVHU0MMYwMPGQMlL
         gTlCfBku9Y1WxFmm2ugbAEL8wQS/HbBxKMDasGAEqK7MbftIKtC4zuNt7Dz48YivPKvz
         RnCg==
X-Forwarded-Encrypted: i=1; AJvYcCVNnqjvrYP/VEGNf4WeQ9ZjQvrmwo+strqzrdEAW1cc0S5aJcXtcrBE7boPZg7c+BowSt/Or3tB22vlKU2C5NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdTcA6emNwxIeYd+mrKveKRHC8YryCSh5jPDkEHM9/wC9d0ae
	fTva93gVn98+xKaSfTUu+yCANDbFDlB2ZHXFLbk0r/Q7AQO6AVP6GexCNk/VJk6ApoCbGXphqlE
	BH1L9kSaZBoRhOOy/DKEARw==
X-Google-Smtp-Source: AGHT+IH3N5qL0TDHwb+ahMnzs9ETG7Svm+A6F+qfQL1tieuJZR8fE0gET637CAqDRn32FQw0mJ0L0E81ldHixRjnIw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:c93:b0:6b0:57ec:c5f9 with
 SMTP id 00721157ae682-6db44a59f17mr6527007b3.0.1726011939045; Tue, 10 Sep
 2024 16:45:39 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:44:09 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <3ef4b32d32dca6e1b506e967c950dc2d4c3bc7ae.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 38/39] KVM: selftests: Update private_mem_conversions_test
 for mmap()able guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86_64/private_mem_conversions_test.c | 146 +++++++++++++++---
 .../x86_64/private_mem_conversions_test.sh    |   3 +
 2 files changed, 124 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
index 71f480c19f92..6524ef398584 100644
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
@@ -11,6 +11,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
 
 #include <linux/compiler.h>
 #include <linux/kernel.h>
@@ -202,15 +204,19 @@ static void guest_test_explicit_conversion(uint64_t base_gpa, bool do_fallocate)
 		guest_sync_shared(gpa, size, p3, p4);
 		memcmp_g(gpa, p4, size);
 
-		/* Reset the shared memory back to the initial pattern. */
-		memset((void *)gpa, init_p, size);
-
 		/*
 		 * Free (via PUNCH_HOLE) *all* private memory so that the next
 		 * iteration starts from a clean slate, e.g. with respect to
 		 * whether or not there are pages/folios in guest_mem.
 		 */
 		guest_map_shared(base_gpa, PER_CPU_DATA_SIZE, true);
+
+		/*
+		 * Reset the entire block back to the initial pattern. Do this
+		 * after fallocate(PUNCH_HOLE) because hole-punching zeroes
+		 * memory.
+		 */
+		memset((void *)base_gpa, init_p, PER_CPU_DATA_SIZE);
 	}
 }
 
@@ -286,7 +292,8 @@ static void guest_code(uint64_t base_gpa)
 	GUEST_DONE();
 }
 
-static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
+static void handle_exit_hypercall(struct kvm_vcpu *vcpu,
+				  bool back_shared_memory_with_guest_memfd)
 {
 	struct kvm_run *run = vcpu->run;
 	uint64_t gpa = run->hypercall.args[0];
@@ -303,17 +310,46 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 	if (do_fallocate)
 		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
 
-	if (set_attributes)
+	if (set_attributes) {
+		if (back_shared_memory_with_guest_memfd && !map_shared)
+			vm_guest_mem_madvise(vm, gpa, size, MADV_DONTNEED);
 		vm_set_memory_attributes(vm, gpa, size,
 					 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	}
 	run->hypercall.ret = 0;
 }
 
+static void assert_not_faultable(uint8_t *address)
+{
+	pid_t child_pid;
+
+	child_pid = fork();
+	TEST_ASSERT(child_pid != -1, "fork failed");
+
+	if (child_pid == 0) {
+		*address = 'A';
+	} else {
+		int status;
+		waitpid(child_pid, &status, 0);
+
+		TEST_ASSERT(WIFSIGNALED(status),
+			    "Child should have exited with a signal");
+		TEST_ASSERT_EQ(WTERMSIG(status), SIGBUS);
+	}
+}
+
 static bool run_vcpus;
 
-static void *__test_mem_conversions(void *__vcpu)
+struct test_thread_args
 {
-	struct kvm_vcpu *vcpu = __vcpu;
+	struct kvm_vcpu *vcpu;
+	bool back_shared_memory_with_guest_memfd;
+};
+
+static void *__test_mem_conversions(void *params)
+{
+	struct test_thread_args *args = params;
+	struct kvm_vcpu *vcpu = args->vcpu;
 	struct kvm_run *run = vcpu->run;
 	struct kvm_vm *vm = vcpu->vm;
 	struct ucall uc;
@@ -325,7 +361,8 @@ static void *__test_mem_conversions(void *__vcpu)
 		vcpu_run(vcpu);
 
 		if (run->exit_reason == KVM_EXIT_HYPERCALL) {
-			handle_exit_hypercall(vcpu);
+			handle_exit_hypercall(vcpu,
+					      args->back_shared_memory_with_guest_memfd);
 			continue;
 		}
 
@@ -349,8 +386,18 @@ static void *__test_mem_conversions(void *__vcpu)
 				size_t nr_bytes = min_t(size_t, vm->page_size, size - i);
 				uint8_t *hva = addr_gpa2hva(vm, gpa + i);
 
-				/* In all cases, the host should observe the shared data. */
-				memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+				/* Check contents of memory */
+				if (args->back_shared_memory_with_guest_memfd &&
+				    uc.args[0] == SYNC_PRIVATE) {
+					assert_not_faultable(hva);
+				} else {
+					/*
+					 * If shared and private memory use
+					 * separate backing memory, the host
+					 * should always observe shared data.
+					 */
+					memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
+				}
 
 				/* For shared, write the new pattern to guest memory. */
 				if (uc.args[0] == SYNC_SHARED)
@@ -366,11 +413,41 @@ static void *__test_mem_conversions(void *__vcpu)
 	}
 }
 
-static void
-test_mem_conversions(enum vm_mem_backing_src_type src_type,
-		     enum vm_private_mem_backing_src_type private_mem_src_type,
-		     uint32_t nr_vcpus,
-		     uint32_t nr_memslots)
+static void add_memslot(struct kvm_vm *vm, uint64_t gpa, uint32_t slot,
+			uint64_t size, int guest_memfd,
+			uint64_t guest_memfd_offset,
+			enum vm_mem_backing_src_type src_type,
+			bool back_shared_memory_with_guest_memfd)
+{
+	struct userspace_mem_region *region;
+
+	if (!back_shared_memory_with_guest_memfd) {
+		vm_mem_add(vm, src_type, gpa, slot, size / vm->page_size,
+			   KVM_MEM_GUEST_MEMFD, guest_memfd,
+			   guest_memfd_offset);
+		return;
+	}
+
+	region = vm_mem_region_alloc(vm);
+
+	guest_memfd = vm_mem_region_install_guest_memfd(region, guest_memfd);
+
+	vm_mem_region_mmap(region, size, MAP_SHARED, guest_memfd, guest_memfd_offset);
+	vm_mem_region_install_memory(region, size, getpagesize());
+
+	region->region.slot = slot;
+	region->region.flags = KVM_MEM_GUEST_MEMFD;
+	region->region.guest_phys_addr = gpa;
+	region->region.guest_memfd_offset = guest_memfd_offset;
+
+	vm_mem_region_add(vm, region);
+}
+
+static void test_mem_conversions(enum vm_mem_backing_src_type src_type,
+				 enum vm_private_mem_backing_src_type private_mem_src_type,
+				 uint32_t nr_vcpus,
+				 uint32_t nr_memslots,
+				 bool back_shared_memory_with_guest_memfd)
 {
 	/*
 	 * Allocate enough memory so that each vCPU's chunk of memory can be
@@ -381,6 +458,7 @@ test_mem_conversions(enum vm_mem_backing_src_type src_type,
 					     get_private_mem_backing_src_pagesz(private_mem_src_type),
 					     get_backing_src_pagesz(src_type)));
 	const size_t per_cpu_size = align_up(PER_CPU_DATA_SIZE, alignment);
+	struct test_thread_args *thread_args[KVM_MAX_VCPUS];
 	const size_t memfd_size = per_cpu_size * nr_vcpus;
 	const size_t slot_size = memfd_size / nr_memslots;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
@@ -404,13 +482,14 @@ test_mem_conversions(enum vm_mem_backing_src_type src_type,
 		vm, memfd_size,
 		vm_private_mem_backing_src_alias(private_mem_src_type)->flag);
 
-	for (i = 0; i < nr_memslots; i++)
-		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
-			   BASE_DATA_SLOT + i, slot_size / vm->page_size,
-			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i);
+	for (i = 0; i < nr_memslots; i++) {
+		add_memslot(vm, BASE_DATA_GPA + slot_size * i,
+			    BASE_DATA_SLOT + i, slot_size, memfd, slot_size * i,
+			    src_type, back_shared_memory_with_guest_memfd);
+	}
 
 	for (i = 0; i < nr_vcpus; i++) {
-		uint64_t gpa =  BASE_DATA_GPA + i * per_cpu_size;
+		uint64_t gpa = BASE_DATA_GPA + i * per_cpu_size;
 
 		vcpu_args_set(vcpus[i], 1, gpa);
 
@@ -420,13 +499,23 @@ test_mem_conversions(enum vm_mem_backing_src_type src_type,
 		 */
 		virt_map(vm, gpa, gpa, PER_CPU_DATA_SIZE / vm->page_size);
 
-		pthread_create(&threads[i], NULL, __test_mem_conversions, vcpus[i]);
+		thread_args[i] = malloc(sizeof(struct test_thread_args));
+		TEST_ASSERT(thread_args[i] != NULL,
+			    "Could not allocate memory for thread parameters");
+		thread_args[i]->vcpu = vcpus[i];
+		thread_args[i]->back_shared_memory_with_guest_memfd =
+			back_shared_memory_with_guest_memfd;
+
+		pthread_create(&threads[i], NULL, __test_mem_conversions,
+			       (void *)thread_args[i]);
 	}
 
 	WRITE_ONCE(run_vcpus, true);
 
-	for (i = 0; i < nr_vcpus; i++)
+	for (i = 0; i < nr_vcpus; i++) {
 		pthread_join(threads[i], NULL);
+		free(thread_args[i]);
+	}
 
 	kvm_vm_free(vm);
 
@@ -448,7 +537,7 @@ test_mem_conversions(enum vm_mem_backing_src_type src_type,
 static void usage(const char *cmd)
 {
 	puts("");
-	printf("usage: %s [-h] [-m nr_memslots] [-s mem_type] [-p private_mem_type] [-n nr_vcpus]\n", cmd);
+	printf("usage: %s [-h] [-m nr_memslots] [-s mem_type] [-p private_mem_type] [-n nr_vcpus] [-g]\n", cmd);
 	puts("");
 	backing_src_help("-s");
 	puts("");
@@ -458,19 +547,22 @@ static void usage(const char *cmd)
 	puts("");
 	puts(" -m: specify the number of memslots (default: 1)");
 	puts("");
+	puts(" -g: back shared memory with guest_memfd (default: false)");
+	puts("");
 }
 
 int main(int argc, char *argv[])
 {
 	enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
 	enum vm_private_mem_backing_src_type private_mem_src_type = DEFAULT_VM_PRIVATE_MEM_SRC;
+	bool back_shared_memory_with_guest_memfd = false;
 	uint32_t nr_memslots = 1;
 	uint32_t nr_vcpus = 1;
 	int opt;
 
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
 
-	while ((opt = getopt(argc, argv, "hm:s:p:n:")) != -1) {
+	while ((opt = getopt(argc, argv, "hgm:s:p:n:")) != -1) {
 		switch (opt) {
 		case 's':
 			src_type = parse_backing_src_type(optarg);
@@ -484,6 +576,9 @@ int main(int argc, char *argv[])
 		case 'm':
 			nr_memslots = atoi_positive("nr_memslots", optarg);
 			break;
+		case 'g':
+			back_shared_memory_with_guest_memfd = true;
+			break;
 		case 'h':
 		default:
 			usage(argv[0]);
@@ -491,7 +586,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	test_mem_conversions(src_type, private_mem_src_type, nr_vcpus, nr_memslots);
+	test_mem_conversions(src_type, private_mem_src_type, nr_vcpus, nr_memslots,
+			     back_shared_memory_with_guest_memfd);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh
index fb6705fef466..c7f3dfee0336 100755
--- a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh
@@ -75,6 +75,9 @@ TEST_EXECUTABLE="$(dirname "$0")/private_mem_conversions_test"
 			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test
 			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test -m $num_memslots_to_test
 
+			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test -g
+			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test -m $num_memslots_to_test -g
+
 			{ set +x; } 2>/dev/null
 
 			echo
-- 
2.46.0.598.g6f2099f65c-goog


