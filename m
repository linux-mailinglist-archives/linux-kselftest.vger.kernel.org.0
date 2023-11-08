Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A757E5DB4
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjKHTAm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjKHTAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628E213A;
        Wed,  8 Nov 2023 11:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470028; x=1731006028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Omys/p1vZU2MObsmFP/k7tn3rHgMvIXZh2s5EOOQwfw=;
  b=H5HDVAPIUntwZZLjoABK03jw3kGSImM1uNzHwdOKNp70dAN1XsXc7/cE
   smzcFeOXBN5fmLiSYlyyE3CD1Ifg21gDgvTIX01V7n5IhumtlR87fnVX4
   oFpBLRL6kaWiBxJOfThIcR5dKw0OUmF3OAkotcj0vnkC/jYq12a4e1sCd
   zhxRjZKjxczXNxYOojDU4FXqC9glU0zE5OpBryWXY6Bag+mw28fMGfFQ/
   z1flIylXCVdBeVmA75oHW//pu1nduld7o0Si3UQsEzP1tMe0N+BoMo9Df
   wObm309vQjm71uayA+B/iRhkvbred87M23QaK8UjOTmlRYIhAqLPME4vw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486444"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486444"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892510"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:26 -0800
From:   Xin Li <xin3.li@intel.com>
To:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, vkuznets@redhat.com, peterz@infradead.org,
        ravi.v.shankar@intel.com
Subject: [PATCH v1 20/23] KVM: selftests: Add FRED VMCS fields to evmcs
Date:   Wed,  8 Nov 2023 10:30:00 -0800
Message-ID: <20231108183003.5981-21-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add FRED VMCS fields to evmcs.

Signed-off-by: Xin Li <xin3.li@intel.com>
---
 .../selftests/kvm/include/x86_64/evmcs.h      | 146 ++++++++++++++++++
 .../selftests/kvm/include/x86_64/vmx.h        |  20 +++
 2 files changed, 166 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/evmcs.h b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
index 901caf0e0939..afd35f0c34fd 100644
--- a/tools/testing/selftests/kvm/include/x86_64/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
@@ -216,6 +216,27 @@ struct hv_enlightened_vmcs {
 	u64 host_ssp;
 	u64 host_ia32_int_ssp_table_addr;
 	u64 padding64_6;
+
+	u64 host_ia32_fred_config;
+	u64 host_ia32_fred_rsp1;
+	u64 host_ia32_fred_rsp2;
+	u64 host_ia32_fred_rsp3;
+	u64 host_ia32_fred_stklvls;
+	u64 host_ia32_fred_ssp1;
+	u64 host_ia32_fred_ssp2;
+	u64 host_ia32_fred_ssp3;
+
+	u64 guest_ia32_fred_config;
+	u64 guest_ia32_fred_rsp1;
+	u64 guest_ia32_fred_rsp2;
+	u64 guest_ia32_fred_rsp3;
+	u64 guest_ia32_fred_stklvls;
+	u64 guest_ia32_fred_ssp1;
+	u64 guest_ia32_fred_ssp2;
+	u64 guest_ia32_fred_ssp3;
+
+	u64 injected_event_data;
+	u64 original_event_data;
 } __packed;
 
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE                     0
@@ -450,6 +471,9 @@ static inline int evmcs_vmread(uint64_t encoding, uint64_t *value)
 	case GUEST_LINEAR_ADDRESS:
 		*value = current_evmcs->guest_linear_address;
 		break;
+	case ORIGINAL_EVENT_DATA:
+		*value = current_evmcs->original_event_data;
+		break;
 	case VM_EXIT_MSR_STORE_ADDR:
 		*value = current_evmcs->vm_exit_msr_store_addr;
 		break;
@@ -492,6 +516,9 @@ static inline int evmcs_vmread(uint64_t encoding, uint64_t *value)
 	case VM_ENTRY_EXCEPTION_ERROR_CODE:
 		*value = current_evmcs->vm_entry_exception_error_code;
 		break;
+	case INJECTED_EVENT_DATA:
+		*value = current_evmcs->injected_event_data;
+		break;
 	case VM_ENTRY_INSTRUCTION_LEN:
 		*value = current_evmcs->vm_entry_instruction_len;
 		break;
@@ -669,6 +696,54 @@ static inline int evmcs_vmread(uint64_t encoding, uint64_t *value)
 	case TSC_MULTIPLIER:
 		*value = current_evmcs->tsc_multiplier;
 		break;
+	case HOST_IA32_FRED_CONFIG:
+		*value = current_evmcs->host_ia32_fred_config;
+		break;
+	case HOST_IA32_FRED_RSP1:
+		*value = current_evmcs->host_ia32_fred_rsp1;
+		break;
+	case HOST_IA32_FRED_RSP2:
+		*value = current_evmcs->host_ia32_fred_rsp2;
+		break;
+	case HOST_IA32_FRED_RSP3:
+		*value = current_evmcs->host_ia32_fred_rsp3;
+		break;
+	case HOST_IA32_FRED_STKLVLS:
+		*value = current_evmcs->host_ia32_fred_stklvls;
+		break;
+	case HOST_IA32_FRED_SSP1:
+		*value = current_evmcs->host_ia32_fred_ssp1;
+		break;
+	case HOST_IA32_FRED_SSP2:
+		*value = current_evmcs->host_ia32_fred_ssp2;
+		break;
+	case HOST_IA32_FRED_SSP3:
+		*value = current_evmcs->host_ia32_fred_ssp3;
+		break;
+	case GUEST_IA32_FRED_CONFIG:
+		*value = current_evmcs->guest_ia32_fred_config;
+		break;
+	case GUEST_IA32_FRED_RSP1:
+		*value = current_evmcs->guest_ia32_fred_rsp1;
+		break;
+	case GUEST_IA32_FRED_RSP2:
+		*value = current_evmcs->guest_ia32_fred_rsp2;
+		break;
+	case GUEST_IA32_FRED_RSP3:
+		*value = current_evmcs->guest_ia32_fred_rsp3;
+		break;
+	case GUEST_IA32_FRED_STKLVLS:
+		*value = current_evmcs->guest_ia32_fred_stklvls;
+		break;
+	case GUEST_IA32_FRED_SSP1:
+		*value = current_evmcs->guest_ia32_fred_ssp1;
+		break;
+	case GUEST_IA32_FRED_SSP2:
+		*value = current_evmcs->guest_ia32_fred_ssp2;
+		break;
+	case GUEST_IA32_FRED_SSP3:
+		*value = current_evmcs->guest_ia32_fred_ssp3;
+		break;
 	default: return 1;
 	}
 
@@ -906,6 +981,10 @@ static inline int evmcs_vmwrite(uint64_t encoding, uint64_t value)
 		current_evmcs->guest_linear_address = value;
 		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE;
 		break;
+	case ORIGINAL_EVENT_DATA:
+		current_evmcs->original_event_data = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE;
+		break;
 	case VM_EXIT_MSR_STORE_ADDR:
 		current_evmcs->vm_exit_msr_store_addr = value;
 		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
@@ -962,6 +1041,10 @@ static inline int evmcs_vmwrite(uint64_t encoding, uint64_t value)
 		current_evmcs->vm_entry_exception_error_code = value;
 		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT;
 		break;
+	case INJECTED_EVENT_DATA:
+		current_evmcs->injected_event_data = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT;
+		break;
 	case VM_ENTRY_INSTRUCTION_LEN:
 		current_evmcs->vm_entry_instruction_len = value;
 		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT;
@@ -1198,6 +1281,69 @@ static inline int evmcs_vmwrite(uint64_t encoding, uint64_t value)
 		current_evmcs->tsc_multiplier = value;
 		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2;
 		break;
+	case HOST_IA32_FRED_CONFIG:
+		current_evmcs->host_ia32_fred_config = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
+		break;
+	case HOST_IA32_FRED_RSP1:
+		current_evmcs->host_ia32_fred_rsp1 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
+		break;
+	case HOST_IA32_FRED_RSP2:
+		current_evmcs->host_ia32_fred_rsp2 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
+		break;
+	case HOST_IA32_FRED_RSP3:
+		current_evmcs->host_ia32_fred_rsp3 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
+		break;
+	case HOST_IA32_FRED_STKLVLS:
+		current_evmcs->host_ia32_fred_stklvls = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
+		break;
+	case HOST_IA32_FRED_SSP1:
+		current_evmcs->host_ia32_fred_ssp1 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
+		break;
+	case HOST_IA32_FRED_SSP2:
+		current_evmcs->host_ia32_fred_ssp2 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
+		break;
+	case HOST_IA32_FRED_SSP3:
+		current_evmcs->host_ia32_fred_ssp3 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
+		break;
+	case GUEST_IA32_FRED_CONFIG:
+		current_evmcs->guest_ia32_fred_config = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2;
+	case GUEST_IA32_FRED_RSP1:
+		current_evmcs->guest_ia32_fred_rsp1 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2;
+		break;
+	case GUEST_IA32_FRED_RSP2:
+		current_evmcs->guest_ia32_fred_rsp2 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2;
+		break;
+	case GUEST_IA32_FRED_RSP3:
+		current_evmcs->guest_ia32_fred_rsp3 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2;
+		break;
+	case GUEST_IA32_FRED_STKLVLS:
+		current_evmcs->guest_ia32_fred_stklvls = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2;
+		break;
+	case GUEST_IA32_FRED_SSP1:
+		current_evmcs->guest_ia32_fred_ssp1 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2;
+		break;
+	case GUEST_IA32_FRED_SSP2:
+		current_evmcs->guest_ia32_fred_ssp2 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2;
+		break;
+	case GUEST_IA32_FRED_SSP3:
+		current_evmcs->guest_ia32_fred_ssp3 = value;
+		current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2;
+		break;
 	default: return 1;
 	}
 
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 5f0c0a29c556..e1fdbc293af7 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -165,8 +165,12 @@ enum vmcs_field {
 	ENCLS_EXITING_BITMAP_HIGH	= 0x0000202F,
 	TSC_MULTIPLIER			= 0x00002032,
 	TSC_MULTIPLIER_HIGH		= 0x00002033,
+	INJECTED_EVENT_DATA		= 0x00002052,
+	INJECTED_EVENT_DATA_HIGH	= 0x00002053,
 	GUEST_PHYSICAL_ADDRESS		= 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH	= 0x00002401,
+	ORIGINAL_EVENT_DATA		= 0x00002404,
+	ORIGINAL_EVENT_DATA_HIGH	= 0x00002405,
 	VMCS_LINK_POINTER		= 0x00002800,
 	VMCS_LINK_POINTER_HIGH		= 0x00002801,
 	GUEST_IA32_DEBUGCTL		= 0x00002802,
@@ -187,12 +191,28 @@ enum vmcs_field {
 	GUEST_PDPTR3_HIGH		= 0x00002811,
 	GUEST_BNDCFGS			= 0x00002812,
 	GUEST_BNDCFGS_HIGH		= 0x00002813,
+	GUEST_IA32_FRED_CONFIG		= 0x0000281a,
+	GUEST_IA32_FRED_RSP1		= 0x0000281c,
+	GUEST_IA32_FRED_RSP2		= 0x0000281e,
+	GUEST_IA32_FRED_RSP3		= 0x00002820,
+	GUEST_IA32_FRED_STKLVLS		= 0x00002822,
+	GUEST_IA32_FRED_SSP1		= 0x00002824,
+	GUEST_IA32_FRED_SSP2		= 0x00002826,
+	GUEST_IA32_FRED_SSP3		= 0x00002828,
 	HOST_IA32_PAT			= 0x00002c00,
 	HOST_IA32_PAT_HIGH		= 0x00002c01,
 	HOST_IA32_EFER			= 0x00002c02,
 	HOST_IA32_EFER_HIGH		= 0x00002c03,
 	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,
 	HOST_IA32_PERF_GLOBAL_CTRL_HIGH	= 0x00002c05,
+	HOST_IA32_FRED_CONFIG		= 0x00002c08,
+	HOST_IA32_FRED_RSP1		= 0x00002c0a,
+	HOST_IA32_FRED_RSP2		= 0x00002c0c,
+	HOST_IA32_FRED_RSP3		= 0x00002c0e,
+	HOST_IA32_FRED_STKLVLS		= 0x00002c10,
+	HOST_IA32_FRED_SSP1		= 0x00002c12,
+	HOST_IA32_FRED_SSP2		= 0x00002c14,
+	HOST_IA32_FRED_SSP3		= 0x00002c16,
 	PIN_BASED_VM_EXEC_CONTROL	= 0x00004000,
 	CPU_BASED_VM_EXEC_CONTROL	= 0x00004002,
 	EXCEPTION_BITMAP		= 0x00004004,
-- 
2.42.0

