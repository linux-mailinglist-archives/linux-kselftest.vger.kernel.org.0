Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9F742C47A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhJMPKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 11:10:21 -0400
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:14817
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbhJMPKU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 11:10:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9oRtsI6Xe4pBEonoe0Br1OEAIbl08yK+fbLrRg+Kz002vvWOOXgwc7BAgmxilMSWEVCFG/cr22gtqVo32qLVTw6VFvM5liM+jQn4u6VDeaKcGi7NMlv35LD17dn0zqvDpDBvyG7RKpCVuAYP3BMFdplXkU+SwDWZwI5tsboDxWEtze0y02KeZzOY/0OcOXs2FC4NJO3CT8Z5CS2X0gGP9embXrEzR10dWIZvvqkUctNR29HfvTeRdZ8w03ylahosdH1kue6boT50s/X7h6XNW8P5Xu5xaGVFMz1Pzb7pHV7ds+kUPRPRBfHQwlamEU8ziKaTRAt/W0vAo0H81VPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niGBCFtTL/IkMldIcNyhXF4BHzYR/A2x3rH15O+pxA4=;
 b=Y+QiwmRyEeZzNYNkts0QmKp0OBYPdArOcWU1VNQeaF8Wrlp+94mbEByVvT/sxa9c0VJXvw+1fokRYmvUJaGNw4KCwlrVta2kXJ9xrw/rvUUesQkB51wh12P6JqkmrShDGv/j9p4srJv1VWzRjSZCtConRADvFAiMRKElXeysRe7P/XPh9mlCG9AojO0/Rk4VDTmwAOcpc8F8AlN2B7l9w4WwHMtnMBVSRb4CF/ChfTf1bCA/FB7ztkMmsuokz/dhhKF+3EX87OzStPfbuqRuydTqPJaNY2phgPKR4LxvJBq2OMBKn31YJ/vliuLfMhBchxs/CEkADGIBDCBf/839CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niGBCFtTL/IkMldIcNyhXF4BHzYR/A2x3rH15O+pxA4=;
 b=mbE9ei1hBnPpM0NR7HRuWiaZNyyWyTjwRIf4MTMmTPy4nNoICrhgxUXbZ0b9N8TXu8Ngg8tEA2lZr7eyq6jK839iUA61RoVjNDkrndHnuJzhOIZNrbFllDwWkVFE9n6EQb1hH9eDAkmyVAvhdtfho/cMvU2n/JXHn3Lmw90hnbk=
Received: from CO1PR15CA0091.namprd15.prod.outlook.com (2603:10b6:101:21::11)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Wed, 13 Oct
 2021 15:08:13 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::67) by CO1PR15CA0091.outlook.office365.com
 (2603:10b6:101:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 15:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:08:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 10:08:12 -0500
Date:   Wed, 13 Oct 2021 10:07:19 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>
CC:     <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Mingwei Zhang" <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 02/16] KVM: selftests: add hooks for managing encrypted
 guest memory
Message-ID: <20211013150719.mnde2lw6ffks7pm4@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211005234459.430873-3-michael.roth@amd.com>
 <6b8e4fb7-fb96-bc3a-dc46-70d9f07d3c8d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b8e4fb7-fb96-bc3a-dc46-70d9f07d3c8d@oracle.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7bc22be-e4b8-4cb1-5578-08d98e5b46ec
X-MS-TrafficTypeDiagnostic: DM6PR12MB4369:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43697DD10784AF9AF6632C0C95B79@DM6PR12MB4369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkNaqGsMLNM1nQZNsmCCjfb0fWgoSzKS9dNle/GElPoV4FXwlWzjG6Q93V+EYlKaD7zNB4BPHP3NUU/+vc69tJevq7TKF94KAh205G337nWV16twBLdJUdxhOYHhtWvUulit4Go47I0YChvoEYGVSZdbZZ4XsHxtUSeSu3F1HvEVVRGTq6msGYhLZy5T1Wnb/l20cYlmgQ5FMiSqjbmU/xTsoFff29BG8XpwMTn/AJE5SMktwNGwwidfSu8ZZVyfnnajqyTgLPO1j76rzRjEO61GBMa61QGTXsn5WqI9iw7UeAtaJGCjQ7E/9woR1pTDFjYSUwTlSyhiGVIGPO8wLAoShQ357QoU9we3bIWc7M3Pdyz6OaCuGrzOCbWIcHCeGO2+q5mZq5dy23y7/vlwxgW0blTx3xFqkZRXky6CW/27VMJXnBlV2YOhDKbL8/6686woFIKo+g29T5VmDicf+pajg+jD1xOVLPHS5DyQlpNcd3Z4JwZOzQ50a64jGosVusJH/BxuAY6EU7LKz64dW3g5uinynOSB15eWKJezx1spsfM3RpWjKSNPXRizPa6ZGaMpDAL8jdjeNX25WRWLLdoNwtjhA1QCjEUoUPkLW++6xkmbLyjNZgeXMdjimMfuivCbuS9EeC2WpotYkDea3QMH6ak7vugN5rY1SgvssUtkoYKSQKJpJL3orrPZPclomJVkS2aAQElOaZChBkQFSpVyjsYTen4Qi2xCaVjUC/M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(81166007)(426003)(336012)(6916009)(508600001)(36860700001)(2906002)(5660300002)(2616005)(7416002)(316002)(8676002)(54906003)(44832011)(83380400001)(4326008)(16526019)(86362001)(47076005)(82310400003)(8936002)(70586007)(1076003)(186003)(53546011)(36756003)(356005)(70206006)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:08:13.1208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bc22be-e4b8-4cb1-5578-08d98e5b46ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 12, 2021 at 07:20:41PM -0700, Krish Sadhukhan wrote:
> 
> On 10/5/21 4:44 PM, Michael Roth wrote:
> > VM implementations that make use of encrypted memory need a way to
> > configure things like the encryption/shared bit position for page
> > table handling, the default encryption policy for internal allocations
> > made by the core library, and a way to fetch the list/bitmap of
> > encrypted pages to do the actual memory encryption. Add an interface to
> > configure these parameters. Also introduce a sparsebit map to track
> > allocations/mappings that should be treated as encrypted, and provide
> > a way for VM implementations to retrieve it to handle operations
> > related memory encryption.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >   .../testing/selftests/kvm/include/kvm_util.h  |  6 ++
> >   tools/testing/selftests/kvm/lib/kvm_util.c    | 63 +++++++++++++++++--
> >   .../selftests/kvm/lib/kvm_util_internal.h     | 10 +++
> >   3 files changed, 75 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index 010b59b13917..f417de80596c 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -348,6 +348,12 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
> >   void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid);
> > +void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
> > +			      uint8_t enc_bit);
> > +struct sparsebit *vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot,
> > +					     vm_paddr_t *gpa_start,
> > +					     uint64_t *size);
> > +
> >   /* Common ucalls */
> >   enum {
> >   	UCALL_NONE,
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 92f59adddebe..c58f930dedd2 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -631,6 +631,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
> >   		    "rc: %i errno: %i", ret, errno);
> >   	sparsebit_free(&region->unused_phy_pages);
> > +	sparsebit_free(&region->encrypted_phy_pages);
> >   	ret = munmap(region->mmap_start, region->mmap_size);
> >   	TEST_ASSERT(ret == 0, "munmap failed, rc: %i errno: %i", ret, errno);
> > @@ -924,6 +925,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
> >   	}
> >   	region->unused_phy_pages = sparsebit_alloc();
> > +	region->encrypted_phy_pages = sparsebit_alloc();
> >   	sparsebit_set_num(region->unused_phy_pages,
> >   		guest_paddr >> vm->page_shift, npages);
> >   	region->region.slot = slot;
> > @@ -1153,6 +1155,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
> >    *   num - number of pages
> >    *   paddr_min - Physical address minimum
> >    *   memslot - Memory region to allocate page from
> > + *   encrypt - Whether to treat the pages as encrypted
> >    *
> >    * Output Args: None
> >    *
> > @@ -1164,11 +1167,13 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
> >    * and their base address is returned. A TEST_ASSERT failure occurs if
> >    * not enough pages are available at or above paddr_min.
> >    */
> > -vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> > -			      vm_paddr_t paddr_min, uint32_t memslot)
> > +static vm_paddr_t
> > +_vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, vm_paddr_t paddr_min,
> > +		    uint32_t memslot, bool encrypt)
> >   {
> >   	struct userspace_mem_region *region;
> >   	sparsebit_idx_t pg, base;
> > +	vm_paddr_t gpa;
> >   	TEST_ASSERT(num > 0, "Must allocate at least one page");
> > @@ -1198,10 +1203,25 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> >   		abort();
> >   	}
> > -	for (pg = base; pg < base + num; ++pg)
> > +	for (pg = base; pg < base + num; ++pg) {
> >   		sparsebit_clear(region->unused_phy_pages, pg);
> > +		if (encrypt)
> > +			sparsebit_set(region->encrypted_phy_pages, pg);
> > +	}
> > +
> > +	gpa = base * vm->page_size;
> > -	return base * vm->page_size;
> > +	if (encrypt && vm->memcrypt.has_enc_bit)
> > +		gpa |= (1ULL << vm->memcrypt.enc_bit);
> > +
> > +	return gpa;
> > +}
> > +
> > +vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
> > +			      vm_paddr_t paddr_min, uint32_t memslot)
> > +{
> > +	return _vm_phy_pages_alloc(vm, 1, paddr_min, memslot,
> > +				   vm->memcrypt.enc_by_default);
> >   }
> >   vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
> > @@ -2146,6 +2166,10 @@ void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
> >   			region->host_mem);
> >   		fprintf(stream, "%*sunused_phy_pages: ", indent + 2, "");
> >   		sparsebit_dump(stream, region->unused_phy_pages, 0);
> > +		if (vm->memcrypt.enabled) {
> > +			fprintf(stream, "%*sencrypted_phy_pages: ", indent + 2, "");
> > +			sparsebit_dump(stream, region->encrypted_phy_pages, 0);
> > +		}
> >   	}
> >   	fprintf(stream, "%*sMapped Virtual Pages:\n", indent, "");
> >   	sparsebit_dump(stream, vm->vpages_mapped, indent + 2);
> > @@ -2343,3 +2367,34 @@ int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
> >   	return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
> >   }
> > +
> > +void vm_set_memory_encryption(struct kvm_vm *vm, bool enc_by_default, bool has_enc_bit,
> > +			      uint8_t enc_bit)
> > +{
> > +	vm->memcrypt.enabled = true;
> > +	vm->memcrypt.enc_by_default = enc_by_default;
> > +	vm->memcrypt.has_enc_bit = has_enc_bit;
> > +	vm->memcrypt.enc_bit = enc_bit;
> > +}
> > +
> > +struct sparsebit *
> > +vm_get_encrypted_phy_pages(struct kvm_vm *vm, int slot, vm_paddr_t *gpa_start,
> > +			   uint64_t *size)
> > +{
> > +	struct userspace_mem_region *region;
> > +	struct sparsebit *encrypted_phy_pages;
> > +
> > +	if (!vm->memcrypt.enabled)
> > +		return NULL;
> > +
> > +	region = memslot2region(vm, slot);
> > +	if (!region)
> > +		return NULL;
> > +
> > +	encrypted_phy_pages = sparsebit_alloc();
> > +	sparsebit_copy(encrypted_phy_pages, region->encrypted_phy_pages);
> > +	*size = region->region.memory_size;
> > +	*gpa_start = region->region.guest_phys_addr;
> > +
> > +	return encrypted_phy_pages;
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> > index a03febc24ba6..99ccab86115c 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> > @@ -16,6 +16,7 @@
> >   struct userspace_mem_region {
> >   	struct kvm_userspace_memory_region region;
> >   	struct sparsebit *unused_phy_pages;
> > +	struct sparsebit *encrypted_phy_pages;
> >   	int fd;
> >   	off_t offset;
> >   	void *host_mem;
> > @@ -44,6 +45,14 @@ struct userspace_mem_regions {
> >   	DECLARE_HASHTABLE(slot_hash, 9);
> >   };
> > +/* Memory encryption policy/configuration. */
> > +struct vm_memcrypt {
> > +	bool enabled;
> > +	int8_t enc_by_default;
> > +	bool has_enc_bit;
> > +	int8_t enc_bit;
> > +};
> > +
> >   struct kvm_vm {
> >   	int mode;
> >   	unsigned long type;
> > @@ -67,6 +76,7 @@ struct kvm_vm {
> >   	vm_vaddr_t idt;
> >   	vm_vaddr_t handlers;
> >   	uint32_t dirty_ring_size;
> > +	struct vm_memcrypt memcrypt;
> 
> 
> For readability, it's probably better to adopt a standard naming convention
> for structures, members and  functions ?  For example,
> 
>         encrypted_phy_pages    ->     enc_phy_pages
> 
>         struct vm_memcrypt  {    ->    struct vm_mem_enc {
> 
>         struct vm_memcrypt memcrypt    ->    struct vm_mem_enc  mem_enc
> 
>         vm_get_encrypted_phy_pages()    -> vm_get_enc_phy_pages
> 
> 
> 

Makes sense, I will use this naming convention for the next spin.
