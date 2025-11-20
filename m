Return-Path: <linux-kselftest+bounces-46100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F65AC74099
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 13:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 85FE3299D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47D23375CB;
	Thu, 20 Nov 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjR5Y0fr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DF336ED9;
	Thu, 20 Nov 2025 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643135; cv=none; b=kdmCMK4HLHnLOliBRsSvCX7eCJlu/bF9Ung/dvPhb2F59CBkwwafIpBmD4PtRJiBhr4ClxNE/b+8HBdquuIsTdrbAM11xio7DMK7VmS7nRumnyTCtXR9H9kKNYG6yyZG5ln+fzgOAlPJlkZJ5JtDNsFEwVzzorf3j2sXXsR0rJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643135; c=relaxed/simple;
	bh=jnVwPxCw2gfFolAW4sJRwUYBqtMf1DB5IvWbM2ZFPPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlO3ZAz/+BmLlrZbn9wGF/clbXLTxNm5kQZAlyn1JdtdwRrQld7D83rzkRt9YlHJsi83nN9l4d9XTON4UhJOP23MKQz2PZws8jbG5FVTQnIEuTLJInJYXhMJ6X6ggtKnW8iA4YTMlCrWAHTPbXZJrP4Q6MGOGnkJi9Q+Il14p30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjR5Y0fr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763643133; x=1795179133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jnVwPxCw2gfFolAW4sJRwUYBqtMf1DB5IvWbM2ZFPPU=;
  b=EjR5Y0frLKTmt2daCiAKP2Rn2hvt/aBDj5D0lkeq7egzKrtWh9TGgxZ+
   MYQtVXyNz4PzLr35rl24+QQYYw+Hy2fXFzU/w16IloZp5B8AU22jqGKSJ
   CRMH5uLB5L7xBRW+P6YhbbFZLjHTi8jcxXr+tQem4zfhCrgArrQXXoaGY
   TAbuqqMkw7LLYjhiPW9FW7gmdcXMoxfv6SlB2eGxN6+H2Ci7Ww34qcSuS
   t8xu9PdU84qo6hrjfoIYfLpXSmOLfC5fIEyjGpbmq7RqvTGqqBo7CQ6SF
   7YZvUkLfRi1ORPK7S0yFAYSeix3FQDo/PMJFl/1PfvRrO97WCEeAxdKoL
   w==;
X-CSE-ConnectionGUID: XNM1kOeaQXegk4E8oHxhng==
X-CSE-MsgGUID: 7TA/HEUBSZSCKaIHR0jx7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65603356"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65603356"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 04:52:13 -0800
X-CSE-ConnectionGUID: GpkprCGXSD2ZghouaLwCXQ==
X-CSE-MsgGUID: NTjDsxbhQ3qs06StPHCSrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191478467"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2025 04:52:10 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM48t-00040N-1o;
	Thu, 20 Nov 2025 12:52:07 +0000
Date: Thu, 20 Nov 2025 20:52:06 +0800
From: kernel test robot <lkp@intel.com>
To: griffoul@gmail.com, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, seanjc@google.com, pbonzini@redhat.com,
	vkuznets@redhat.com, shuah@kernel.org, dwmw@amazon.co.uk,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fred Griffoul <fgriffo@amazon.co.uk>
Subject: Re: [PATCH v2 07/10] KVM: nVMX: Replace evmcs kvm_host_map with
 pfncache
Message-ID: <202511202058.xwqVHqfx-lkp@intel.com>
References: <20251118171113.363528-8-griffoul@gmail.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118171113.363528-8-griffoul@gmail.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[also build test WARNING on kvm/next mst-vhost/linux-next linus/master v6.18-rc6 next-20251120]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/griffoul-gmail-com/KVM-nVMX-Implement-cache-for-L1-MSR-bitmap/20251119-012332
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20251118171113.363528-8-griffoul%40gmail.org
patch subject: [PATCH v2 07/10] KVM: nVMX: Replace evmcs kvm_host_map with pfncache
config: x86_64-randconfig-101-20251120 (https://download.01.org/0day-ci/archive/20251120/202511202058.xwqVHqfx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511202058.xwqVHqfx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511202058.xwqVHqfx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/vmx/nested.c:1739:13: warning: 'copy_enlightened_to_vmcs12' defined but not used [-Wunused-function]
    1739 | static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/copy_enlightened_to_vmcs12 +1739 arch/x86/kvm/vmx/nested.c

  1738	
> 1739	static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx,
  1740					       struct hv_enlightened_vmcs *evmcs,
  1741					       u32 hv_clean_fields)
  1742	{
  1743	#ifdef CONFIG_KVM_HYPERV
  1744		struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
  1745		struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(&vmx->vcpu);
  1746	
  1747		/* HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE */
  1748		vmcs12->tpr_threshold = evmcs->tpr_threshold;
  1749		vmcs12->guest_rip = evmcs->guest_rip;
  1750	
  1751		if (unlikely(!(hv_clean_fields &
  1752			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_ENLIGHTENMENTSCONTROL))) {
  1753			hv_vcpu->nested.pa_page_gpa = evmcs->partition_assist_page;
  1754			hv_vcpu->nested.vm_id = evmcs->hv_vm_id;
  1755			hv_vcpu->nested.vp_id = evmcs->hv_vp_id;
  1756		}
  1757	
  1758		if (unlikely(!(hv_clean_fields &
  1759			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC))) {
  1760			vmcs12->guest_rsp = evmcs->guest_rsp;
  1761			vmcs12->guest_rflags = evmcs->guest_rflags;
  1762			vmcs12->guest_interruptibility_info =
  1763				evmcs->guest_interruptibility_info;
  1764			/*
  1765			 * Not present in struct vmcs12:
  1766			 * vmcs12->guest_ssp = evmcs->guest_ssp;
  1767			 */
  1768		}
  1769	
  1770		if (unlikely(!(hv_clean_fields &
  1771			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC))) {
  1772			vmcs12->cpu_based_vm_exec_control =
  1773				evmcs->cpu_based_vm_exec_control;
  1774		}
  1775	
  1776		if (unlikely(!(hv_clean_fields &
  1777			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EXCPN))) {
  1778			vmcs12->exception_bitmap = evmcs->exception_bitmap;
  1779		}
  1780	
  1781		if (unlikely(!(hv_clean_fields &
  1782			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_ENTRY))) {
  1783			vmcs12->vm_entry_controls = evmcs->vm_entry_controls;
  1784		}
  1785	
  1786		if (unlikely(!(hv_clean_fields &
  1787			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT))) {
  1788			vmcs12->vm_entry_intr_info_field =
  1789				evmcs->vm_entry_intr_info_field;
  1790			vmcs12->vm_entry_exception_error_code =
  1791				evmcs->vm_entry_exception_error_code;
  1792			vmcs12->vm_entry_instruction_len =
  1793				evmcs->vm_entry_instruction_len;
  1794		}
  1795	
  1796		if (unlikely(!(hv_clean_fields &
  1797			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1))) {
  1798			vmcs12->host_ia32_pat = evmcs->host_ia32_pat;
  1799			vmcs12->host_ia32_efer = evmcs->host_ia32_efer;
  1800			vmcs12->host_cr0 = evmcs->host_cr0;
  1801			vmcs12->host_cr3 = evmcs->host_cr3;
  1802			vmcs12->host_cr4 = evmcs->host_cr4;
  1803			vmcs12->host_ia32_sysenter_esp = evmcs->host_ia32_sysenter_esp;
  1804			vmcs12->host_ia32_sysenter_eip = evmcs->host_ia32_sysenter_eip;
  1805			vmcs12->host_rip = evmcs->host_rip;
  1806			vmcs12->host_ia32_sysenter_cs = evmcs->host_ia32_sysenter_cs;
  1807			vmcs12->host_es_selector = evmcs->host_es_selector;
  1808			vmcs12->host_cs_selector = evmcs->host_cs_selector;
  1809			vmcs12->host_ss_selector = evmcs->host_ss_selector;
  1810			vmcs12->host_ds_selector = evmcs->host_ds_selector;
  1811			vmcs12->host_fs_selector = evmcs->host_fs_selector;
  1812			vmcs12->host_gs_selector = evmcs->host_gs_selector;
  1813			vmcs12->host_tr_selector = evmcs->host_tr_selector;
  1814			vmcs12->host_ia32_perf_global_ctrl = evmcs->host_ia32_perf_global_ctrl;
  1815			/*
  1816			 * Not present in struct vmcs12:
  1817			 * vmcs12->host_ia32_s_cet = evmcs->host_ia32_s_cet;
  1818			 * vmcs12->host_ssp = evmcs->host_ssp;
  1819			 * vmcs12->host_ia32_int_ssp_table_addr = evmcs->host_ia32_int_ssp_table_addr;
  1820			 */
  1821		}
  1822	
  1823		if (unlikely(!(hv_clean_fields &
  1824			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1))) {
  1825			vmcs12->pin_based_vm_exec_control =
  1826				evmcs->pin_based_vm_exec_control;
  1827			vmcs12->vm_exit_controls = evmcs->vm_exit_controls;
  1828			vmcs12->secondary_vm_exec_control =
  1829				evmcs->secondary_vm_exec_control;
  1830		}
  1831	
  1832		if (unlikely(!(hv_clean_fields &
  1833			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_IO_BITMAP))) {
  1834			vmcs12->io_bitmap_a = evmcs->io_bitmap_a;
  1835			vmcs12->io_bitmap_b = evmcs->io_bitmap_b;
  1836		}
  1837	
  1838		if (unlikely(!(hv_clean_fields &
  1839			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP))) {
  1840			vmcs12->msr_bitmap = evmcs->msr_bitmap;
  1841		}
  1842	
  1843		if (unlikely(!(hv_clean_fields &
  1844			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2))) {
  1845			vmcs12->guest_es_base = evmcs->guest_es_base;
  1846			vmcs12->guest_cs_base = evmcs->guest_cs_base;
  1847			vmcs12->guest_ss_base = evmcs->guest_ss_base;
  1848			vmcs12->guest_ds_base = evmcs->guest_ds_base;
  1849			vmcs12->guest_fs_base = evmcs->guest_fs_base;
  1850			vmcs12->guest_gs_base = evmcs->guest_gs_base;
  1851			vmcs12->guest_ldtr_base = evmcs->guest_ldtr_base;
  1852			vmcs12->guest_tr_base = evmcs->guest_tr_base;
  1853			vmcs12->guest_gdtr_base = evmcs->guest_gdtr_base;
  1854			vmcs12->guest_idtr_base = evmcs->guest_idtr_base;
  1855			vmcs12->guest_es_limit = evmcs->guest_es_limit;
  1856			vmcs12->guest_cs_limit = evmcs->guest_cs_limit;
  1857			vmcs12->guest_ss_limit = evmcs->guest_ss_limit;
  1858			vmcs12->guest_ds_limit = evmcs->guest_ds_limit;
  1859			vmcs12->guest_fs_limit = evmcs->guest_fs_limit;
  1860			vmcs12->guest_gs_limit = evmcs->guest_gs_limit;
  1861			vmcs12->guest_ldtr_limit = evmcs->guest_ldtr_limit;
  1862			vmcs12->guest_tr_limit = evmcs->guest_tr_limit;
  1863			vmcs12->guest_gdtr_limit = evmcs->guest_gdtr_limit;
  1864			vmcs12->guest_idtr_limit = evmcs->guest_idtr_limit;
  1865			vmcs12->guest_es_ar_bytes = evmcs->guest_es_ar_bytes;
  1866			vmcs12->guest_cs_ar_bytes = evmcs->guest_cs_ar_bytes;
  1867			vmcs12->guest_ss_ar_bytes = evmcs->guest_ss_ar_bytes;
  1868			vmcs12->guest_ds_ar_bytes = evmcs->guest_ds_ar_bytes;
  1869			vmcs12->guest_fs_ar_bytes = evmcs->guest_fs_ar_bytes;
  1870			vmcs12->guest_gs_ar_bytes = evmcs->guest_gs_ar_bytes;
  1871			vmcs12->guest_ldtr_ar_bytes = evmcs->guest_ldtr_ar_bytes;
  1872			vmcs12->guest_tr_ar_bytes = evmcs->guest_tr_ar_bytes;
  1873			vmcs12->guest_es_selector = evmcs->guest_es_selector;
  1874			vmcs12->guest_cs_selector = evmcs->guest_cs_selector;
  1875			vmcs12->guest_ss_selector = evmcs->guest_ss_selector;
  1876			vmcs12->guest_ds_selector = evmcs->guest_ds_selector;
  1877			vmcs12->guest_fs_selector = evmcs->guest_fs_selector;
  1878			vmcs12->guest_gs_selector = evmcs->guest_gs_selector;
  1879			vmcs12->guest_ldtr_selector = evmcs->guest_ldtr_selector;
  1880			vmcs12->guest_tr_selector = evmcs->guest_tr_selector;
  1881		}
  1882	
  1883		if (unlikely(!(hv_clean_fields &
  1884			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2))) {
  1885			vmcs12->tsc_offset = evmcs->tsc_offset;
  1886			vmcs12->virtual_apic_page_addr = evmcs->virtual_apic_page_addr;
  1887			vmcs12->xss_exit_bitmap = evmcs->xss_exit_bitmap;
  1888			vmcs12->encls_exiting_bitmap = evmcs->encls_exiting_bitmap;
  1889			vmcs12->tsc_multiplier = evmcs->tsc_multiplier;
  1890		}
  1891	
  1892		if (unlikely(!(hv_clean_fields &
  1893			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR))) {
  1894			vmcs12->cr0_guest_host_mask = evmcs->cr0_guest_host_mask;
  1895			vmcs12->cr4_guest_host_mask = evmcs->cr4_guest_host_mask;
  1896			vmcs12->cr0_read_shadow = evmcs->cr0_read_shadow;
  1897			vmcs12->cr4_read_shadow = evmcs->cr4_read_shadow;
  1898			vmcs12->guest_cr0 = evmcs->guest_cr0;
  1899			vmcs12->guest_cr3 = evmcs->guest_cr3;
  1900			vmcs12->guest_cr4 = evmcs->guest_cr4;
  1901			vmcs12->guest_dr7 = evmcs->guest_dr7;
  1902		}
  1903	
  1904		if (unlikely(!(hv_clean_fields &
  1905			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER))) {
  1906			vmcs12->host_fs_base = evmcs->host_fs_base;
  1907			vmcs12->host_gs_base = evmcs->host_gs_base;
  1908			vmcs12->host_tr_base = evmcs->host_tr_base;
  1909			vmcs12->host_gdtr_base = evmcs->host_gdtr_base;
  1910			vmcs12->host_idtr_base = evmcs->host_idtr_base;
  1911			vmcs12->host_rsp = evmcs->host_rsp;
  1912		}
  1913	
  1914		if (unlikely(!(hv_clean_fields &
  1915			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_XLAT))) {
  1916			vmcs12->ept_pointer = evmcs->ept_pointer;
  1917			vmcs12->virtual_processor_id = evmcs->virtual_processor_id;
  1918		}
  1919	
  1920		if (unlikely(!(hv_clean_fields &
  1921			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1))) {
  1922			vmcs12->vmcs_link_pointer = evmcs->vmcs_link_pointer;
  1923			vmcs12->guest_ia32_debugctl = evmcs->guest_ia32_debugctl;
  1924			vmcs12->guest_ia32_pat = evmcs->guest_ia32_pat;
  1925			vmcs12->guest_ia32_efer = evmcs->guest_ia32_efer;
  1926			vmcs12->guest_pdptr0 = evmcs->guest_pdptr0;
  1927			vmcs12->guest_pdptr1 = evmcs->guest_pdptr1;
  1928			vmcs12->guest_pdptr2 = evmcs->guest_pdptr2;
  1929			vmcs12->guest_pdptr3 = evmcs->guest_pdptr3;
  1930			vmcs12->guest_pending_dbg_exceptions =
  1931				evmcs->guest_pending_dbg_exceptions;
  1932			vmcs12->guest_sysenter_esp = evmcs->guest_sysenter_esp;
  1933			vmcs12->guest_sysenter_eip = evmcs->guest_sysenter_eip;
  1934			vmcs12->guest_bndcfgs = evmcs->guest_bndcfgs;
  1935			vmcs12->guest_activity_state = evmcs->guest_activity_state;
  1936			vmcs12->guest_sysenter_cs = evmcs->guest_sysenter_cs;
  1937			vmcs12->guest_ia32_perf_global_ctrl = evmcs->guest_ia32_perf_global_ctrl;
  1938			/*
  1939			 * Not present in struct vmcs12:
  1940			 * vmcs12->guest_ia32_s_cet = evmcs->guest_ia32_s_cet;
  1941			 * vmcs12->guest_ia32_lbr_ctl = evmcs->guest_ia32_lbr_ctl;
  1942			 * vmcs12->guest_ia32_int_ssp_table_addr = evmcs->guest_ia32_int_ssp_table_addr;
  1943			 */
  1944		}
  1945	
  1946		/*
  1947		 * Not used?
  1948		 * vmcs12->vm_exit_msr_store_addr = evmcs->vm_exit_msr_store_addr;
  1949		 * vmcs12->vm_exit_msr_load_addr = evmcs->vm_exit_msr_load_addr;
  1950		 * vmcs12->vm_entry_msr_load_addr = evmcs->vm_entry_msr_load_addr;
  1951		 * vmcs12->page_fault_error_code_mask =
  1952		 *		evmcs->page_fault_error_code_mask;
  1953		 * vmcs12->page_fault_error_code_match =
  1954		 *		evmcs->page_fault_error_code_match;
  1955		 * vmcs12->cr3_target_count = evmcs->cr3_target_count;
  1956		 * vmcs12->vm_exit_msr_store_count = evmcs->vm_exit_msr_store_count;
  1957		 * vmcs12->vm_exit_msr_load_count = evmcs->vm_exit_msr_load_count;
  1958		 * vmcs12->vm_entry_msr_load_count = evmcs->vm_entry_msr_load_count;
  1959		 */
  1960	
  1961		/*
  1962		 * Read only fields:
  1963		 * vmcs12->guest_physical_address = evmcs->guest_physical_address;
  1964		 * vmcs12->vm_instruction_error = evmcs->vm_instruction_error;
  1965		 * vmcs12->vm_exit_reason = evmcs->vm_exit_reason;
  1966		 * vmcs12->vm_exit_intr_info = evmcs->vm_exit_intr_info;
  1967		 * vmcs12->vm_exit_intr_error_code = evmcs->vm_exit_intr_error_code;
  1968		 * vmcs12->idt_vectoring_info_field = evmcs->idt_vectoring_info_field;
  1969		 * vmcs12->idt_vectoring_error_code = evmcs->idt_vectoring_error_code;
  1970		 * vmcs12->vm_exit_instruction_len = evmcs->vm_exit_instruction_len;
  1971		 * vmcs12->vmx_instruction_info = evmcs->vmx_instruction_info;
  1972		 * vmcs12->exit_qualification = evmcs->exit_qualification;
  1973		 * vmcs12->guest_linear_address = evmcs->guest_linear_address;
  1974		 *
  1975		 * Not present in struct vmcs12:
  1976		 * vmcs12->exit_io_instruction_ecx = evmcs->exit_io_instruction_ecx;
  1977		 * vmcs12->exit_io_instruction_esi = evmcs->exit_io_instruction_esi;
  1978		 * vmcs12->exit_io_instruction_edi = evmcs->exit_io_instruction_edi;
  1979		 * vmcs12->exit_io_instruction_eip = evmcs->exit_io_instruction_eip;
  1980		 */
  1981	
  1982		return;
  1983	#else /* CONFIG_KVM_HYPERV */
  1984		KVM_BUG_ON(1, vmx->vcpu.kvm);
  1985	#endif /* CONFIG_KVM_HYPERV */
  1986	}
  1987	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

