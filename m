Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E407ABA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2019 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfG3O56 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jul 2019 10:57:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731795AbfG3O55 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jul 2019 10:57:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UEvosX121902
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2019 10:57:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u2nnt7ade-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2019 10:57:55 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 30 Jul 2019 15:57:39 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Jul 2019 15:57:36 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6UEvZjS23921000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 14:57:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AF2FA405F;
        Tue, 30 Jul 2019 14:57:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 437D7A4062;
        Tue, 30 Jul 2019 14:57:34 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.144.206])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jul 2019 14:57:34 +0000 (GMT)
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 mQINBE6cPPgBEAC2VpALY0UJjGmgAmavkL/iAdqul2/F9ONz42K6NrwmT+SI9CylKHIX+fdf
 J34pLNJDmDVEdeb+brtpwC9JEZOLVE0nb+SR83CsAINJYKG3V1b3Kfs0hydseYKsBYqJTN2j
 CmUXDYq9J7uOyQQ7TNVoQejmpp5ifR4EzwIFfmYDekxRVZDJygD0wL/EzUr8Je3/j548NLyL
 4Uhv6CIPf3TY3/aLVKXdxz/ntbLgMcfZsDoHgDk3lY3r1iwbWwEM2+eYRdSZaR4VD+JRD7p8
 0FBadNwWnBce1fmQp3EklodGi5y7TNZ/CKdJ+jRPAAnw7SINhSd7PhJMruDAJaUlbYaIm23A
 +82g+IGe4z9tRGQ9TAflezVMhT5J3ccu6cpIjjvwDlbxucSmtVi5VtPAMTLmfjYp7VY2Tgr+
 T92v7+V96jAfE3Zy2nq52e8RDdUo/F6faxcumdl+aLhhKLXgrozpoe2nL0Nyc2uqFjkjwXXI
 OBQiaqGeWtxeKJP+O8MIpjyGuHUGzvjNx5S/592TQO3phpT5IFWfMgbu4OreZ9yekDhf7Cvn
 /fkYsiLDz9W6Clihd/xlpm79+jlhm4E3xBPiQOPCZowmHjx57mXVAypOP2Eu+i2nyQrkapaY
 IdisDQfWPdNeHNOiPnPS3+GhVlPcqSJAIWnuO7Ofw1ZVOyg/jwARAQABtDRDaHJpc3RpYW4g
 Qm9ybnRyYWVnZXIgKElCTSkgPGJvcm50cmFlZ2VyQGRlLmlibS5jb20+iQI4BBMBAgAiBQJO
 nDz4AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRARe7yAtaYcfOYVD/9sqc6ZdYKD
 bmDIvc2/1LL0g7OgiA8pHJlYN2WHvIhUoZUIqy8Sw2EFny/nlpPVWfG290JizNS2LZ0mCeGZ
 80yt0EpQNR8tLVzLSSr0GgoY0lwsKhAnx3p3AOrA8WXsPL6prLAu3yJI5D0ym4MJ6KlYVIjU
 ppi4NLWz7ncA2nDwiIqk8PBGxsjdc/W767zOOv7117rwhaGHgrJ2tLxoGWj0uoH3ZVhITP1z
 gqHXYaehPEELDV36WrSKidTarfThCWW0T3y4bH/mjvqi4ji9emp1/pOWs5/fmd4HpKW+44tD
 Yt4rSJRSa8lsXnZaEPaeY3nkbWPcy3vX6qafIey5d8dc8Uyaan39WslnJFNEx8cCqJrC77kI
 vcnl65HaW3y48DezrMDH34t3FsNrSVv5fRQ0mbEed8hbn4jguFAjPt4az1xawSp0YvhzwATJ
 YmZWRMa3LPx/fAxoolq9cNa0UB3D3jmikWktm+Jnp6aPeQ2Db3C0cDyxcOQY/GASYHY3KNra
 z8iwS7vULyq1lVhOXg1EeSm+lXQ1Ciz3ub3AhzE4c0ASqRrIHloVHBmh4favY4DEFN19Xw1p
 76vBu6QjlsJGjvROW3GRKpLGogQTLslbjCdIYyp3AJq2KkoKxqdeQYm0LZXjtAwtRDbDo71C
 FxS7i/qfvWJv8ie7bE9A6Wsjn7kCDQROnDz4ARAAmPI1e8xB0k23TsEg8O1sBCTXkV8HSEq7
 JlWz7SWyM8oFkJqYAB7E1GTXV5UZcr9iurCMKGSTrSu3ermLja4+k0w71pLxws859V+3z1jr
 nhB3dGzVZEUhCr3EuN0t8eHSLSMyrlPL5qJ11JelnuhToT6535cLOzeTlECc51bp5Xf6/XSx
 SMQaIU1nDM31R13o98oRPQnvSqOeljc25aflKnVkSfqWSrZmb4b0bcWUFFUKVPfQ5Z6JEcJg
 Hp7qPXHW7+tJTgmI1iM/BIkDwQ8qe3Wz8R6rfupde+T70NiId1M9w5rdo0JJsjKAPePKOSDo
 RX1kseJsTZH88wyJ30WuqEqH9zBxif0WtPQUTjz/YgFbmZ8OkB1i+lrBCVHPdcmvathknAxS
 bXL7j37VmYNyVoXez11zPYm+7LA2rvzP9WxR8bPhJvHLhKGk2kZESiNFzP/E4r4Wo24GT4eh
 YrDo7GBHN82V4O9JxWZtjpxBBl8bH9PvGWBmOXky7/bP6h96jFu9ZYzVgIkBP3UYW+Pb1a+b
 w4A83/5ImPwtBrN324bNUxPPqUWNW0ftiR5b81ms/rOcDC/k/VoN1B+IHkXrcBf742VOLID4
 YP+CB9GXrwuF5KyQ5zEPCAjlOqZoq1fX/xGSsumfM7d6/OR8lvUPmqHfAzW3s9n4lZOW5Jfx
 bbkAEQEAAYkCHwQYAQIACQUCTpw8+AIbDAAKCRARe7yAtaYcfPzbD/9WNGVf60oXezNzSVCL
 hfS36l/zy4iy9H9rUZFmmmlBufWOATjiGAXnn0rr/Jh6Zy9NHuvpe3tyNYZLjB9pHT6mRZX7
 Z1vDxeLgMjTv983TQ2hUSlhRSc6e6kGDJyG1WnGQaqymUllCmeC/p9q5m3IRxQrd0skfdN1V
 AMttRwvipmnMduy5SdNayY2YbhWLQ2wS3XHJ39a7D7SQz+gUQfXgE3pf3FlwbwZhRtVR3z5u
 aKjxqjybS3Ojimx4NkWjidwOaUVZTqEecBV+QCzi2oDr9+XtEs0m5YGI4v+Y/kHocNBP0myd
 pF3OoXvcWdTb5atk+OKcc8t4TviKy1WCNujC+yBSq3OM8gbmk6NwCwqhHQzXCibMlVF9hq5a
 FiJb8p4QKSVyLhM8EM3HtiFqFJSV7F+h+2W0kDyzBGyE0D8z3T+L3MOj3JJJkfCwbEbTpk4f
 n8zMboekuNruDw1OADRMPlhoWb+g6exBWx/YN4AY9LbE2KuaScONqph5/HvJDsUldcRN3a5V
 RGIN40QWFVlZvkKIEkzlzqpAyGaRLhXJPv/6tpoQaCQQoSAc5Z9kM/wEd9e2zMeojcWjUXgg
 oWj8A/wY4UXExGBu+UCzzP/6sQRpBiPFgmqPTytrDo/gsUGqjOudLiHQcMU+uunULYQxVghC
 syiRa+UVlsKmx1hsEg==
Date:   Tue, 30 Jul 2019 16:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730100112.18205-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19073014-0012-0000-0000-00000337A7DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073014-0013-0000-0000-000021714DBD
Message-Id: <d48ac43b-c960-54af-a145-360a67b4a3d9@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300155
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 30.07.19 12:01, Thomas Huth wrote:
> To run the dirty_log_test on s390x, we have to make sure that we
> access the dirty log bitmap with little endian byte ordering and
> we have to properly align the memslot of the guest.
> Also all dirty bits of a segment are set once on s390x when one
> of the pages of a segment are written to for the first time, so
> we have to make sure that we touch all pages during the first
> iteration to keep the test in sync here.

While this fixes the test (and the migration does work fine), it still
means that s390x overindicates the dirty bit for sparsely populated
1M segments. It is just a performance issue, but maybe we should try 
to get this fixed. Not sure what to do here to remember us about this, 
adding this as expected fail?
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile         |  1 +
>  tools/testing/selftests/kvm/dirty_log_test.c | 70 ++++++++++++++++++--
>  2 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index ba7849751989..ac7e63e00fee 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -33,6 +33,7 @@ TEST_GEN_PROGS_aarch64 += dirty_log_test
>  TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
>  
>  TEST_GEN_PROGS_s390x += s390x/sync_regs_test
> +TEST_GEN_PROGS_s390x += dirty_log_test
>  TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
>  
>  TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index ceb52b952637..7a1223ad0ff3 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -26,9 +26,22 @@
>  /* The memory slot index to track dirty pages */
>  #define TEST_MEM_SLOT_INDEX		1
>  
> +#ifdef __s390x__
> +
> +/*
> + * On s390x, the ELF program is sometimes linked at 0x80000000, so we can
> + * not use 0x40000000 here without overlapping into that region. Thus let's
> + * use 0xc0000000 as base address there instead.
> + */
> +#define DEFAULT_GUEST_TEST_MEM		0xc0000000
> +
> +#else
> +
>  /* Default guest test memory offset, 1G */
>  #define DEFAULT_GUEST_TEST_MEM		0x40000000
>  
> +#endif
> +
>  /* How many pages to dirty for each guest loop */
>  #define TEST_PAGES_PER_LOOP		1024
>  
> @@ -38,6 +51,27 @@
>  /* Interval for each host loop (ms) */
>  #define TEST_HOST_LOOP_INTERVAL		10UL
>  
> +/* Dirty bitmaps are always little endian, so we need to swap on big endian */
> +#if defined(__s390x__)
> +# define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
> +# define test_bit_le(nr, addr) \
> +	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> +# define set_bit_le(nr, addr) \
> +	set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> +# define clear_bit_le(nr, addr) \
> +	clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> +# define test_and_set_bit_le(nr, addr) \
> +	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> +# define test_and_clear_bit_le(nr, addr) \
> +	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
> +#else
> +# define test_bit_le	test_bit
> +# define set_bit_le	set_bit
> +# define clear_bit_le	clear_bit
> +# define test_and_set_bit_le	test_and_set_bit
> +# define test_and_clear_bit_le	test_and_clear_bit
> +#endif
> +
>  /*
>   * Guest/Host shared variables. Ensure addr_gva2hva() and/or
>   * sync_global_to/from_guest() are used when accessing from
> @@ -69,11 +103,25 @@ static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
>   */
>  static void guest_code(void)
>  {
> +	uint64_t addr;
>  	int i;
>  
> +#ifdef __s390x__
> +	/*
> +	 * On s390x, all pages of a 1M segment are initially marked as dirty
> +	 * when a page of the segment is written to for the very first time.
> +	 * To compensate this specialty in this test, we need to touch all
> +	 * pages during the first iteration.
> +	 */
> +	for (i = 0; i < guest_num_pages; i++) {
> +		addr = guest_test_virt_mem + i * guest_page_size;
> +		*(uint64_t *)addr = READ_ONCE(iteration);
> +	}
> +#endif
> +
>  	while (true) {
>  		for (i = 0; i < TEST_PAGES_PER_LOOP; i++) {
> -			uint64_t addr = guest_test_virt_mem;
> +			addr = guest_test_virt_mem;
>  			addr += (READ_ONCE(random_array[i]) % guest_num_pages)
>  				* guest_page_size;
>  			addr &= ~(host_page_size - 1);
> @@ -158,15 +206,15 @@ static void vm_dirty_log_verify(unsigned long *bmap)
>  		value_ptr = host_test_mem + page * host_page_size;
>  
>  		/* If this is a special page that we were tracking... */
> -		if (test_and_clear_bit(page, host_bmap_track)) {
> +		if (test_and_clear_bit_le(page, host_bmap_track)) {
>  			host_track_next_count++;
> -			TEST_ASSERT(test_bit(page, bmap),
> +			TEST_ASSERT(test_bit_le(page, bmap),
>  				    "Page %"PRIu64" should have its dirty bit "
>  				    "set in this iteration but it is missing",
>  				    page);
>  		}
>  
> -		if (test_bit(page, bmap)) {
> +		if (test_bit_le(page, bmap)) {
>  			host_dirty_count++;
>  			/*
>  			 * If the bit is set, the value written onto
> @@ -209,7 +257,7 @@ static void vm_dirty_log_verify(unsigned long *bmap)
>  				 * should report its dirtyness in the
>  				 * next run
>  				 */
> -				set_bit(page, host_bmap_track);
> +				set_bit_le(page, host_bmap_track);
>  			}
>  		}
>  	}
> @@ -293,6 +341,10 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
>  	 * case where the size is not aligned to 64 pages.
>  	 */
>  	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
> +#ifdef __s390x__
> +	/* Round up to multiple of 1M (segment size) */
> +	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
> +#endif
>  	host_page_size = getpagesize();
>  	host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
>  			 !!((guest_num_pages * guest_page_size) % host_page_size);
> @@ -304,6 +356,11 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
>  		guest_test_phys_mem = phys_offset;
>  	}
>  
> +#ifdef __s390x__
> +	/* Align to 1M (segment size) */
> +	guest_test_phys_mem &= ~((1 << 20) - 1);
> +#endif
> +
>  	DEBUG("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
>  
>  	bmap = bitmap_alloc(host_num_pages);
> @@ -454,6 +511,9 @@ int main(int argc, char *argv[])
>  		vm_guest_mode_params_init(VM_MODE_P48V48_64K, true, true);
>  	}
>  #endif
> +#ifdef __s390x__
> +	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
> +#endif
>  
>  	while ((opt = getopt(argc, argv, "hi:I:p:m:")) != -1) {
>  		switch (opt) {
> 

