Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7891A1BB66A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Apr 2020 08:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD1GVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Apr 2020 02:21:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbgD1GVT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Apr 2020 02:21:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S624hV019679;
        Tue, 28 Apr 2020 02:21:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggu13fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 02:21:09 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03S63L2l024429;
        Tue, 28 Apr 2020 02:21:09 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mggu13ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 02:21:08 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03S6ERls018737;
        Tue, 28 Apr 2020 06:21:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5ney1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 06:21:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03S6L4X260948788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 06:21:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FEB311C05B;
        Tue, 28 Apr 2020 06:21:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B29C11C050;
        Tue, 28 Apr 2020 06:21:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 28 Apr 2020 06:21:03 +0000 (GMT)
Date:   Tue, 28 Apr 2020 08:21:03 +0200
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     svens@stackframe.org, Thomas Gleixner <tglx@linutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/vDSO: make vDSO test work on s390x
Message-ID: <20200428062103.GB62357@tuxmaker.boeblingen.de.ibm.com>
References: <20200404203704.69412-1-svens@linux.ibm.com>
 <20200404203704.69412-2-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404203704.69412-2-svens@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_02:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280046
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 04, 2020 at 10:37:04PM +0200, Sven Schnelle wrote:
> s390x used 8 byte (Elf64_Xword) sized hash table entries.
> Add some code to the vdso test to handle that properly.

Ping?

> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  tools/testing/selftests/vDSO/parse_vdso.c | 14 ++++++++++----
>  tools/testing/selftests/vDSO/vdso_test.c  | 11 +++++++----
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 8e5a70a24d9a..2e1e88ebee3d 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -58,6 +58,12 @@ extern void *vdso_sym(const char *version, const char *name);
>  #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
>  #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
>  
> +#if defined(__s390x__)
> +#define	ELF_HASH_TYPE ELF(Xword)
> +#else
> +#define	ELF_HASH_TYPE ELF(Word)
> +#endif
> +
>  static struct vdso_info
>  {
>  	bool valid;
> @@ -69,8 +75,8 @@ static struct vdso_info
>  	/* Symbol table */
>  	ELF(Sym) *symtab;
>  	const char *symstrings;
> -	ELF(Word) *bucket, *chain;
> -	ELF(Word) nbucket, nchain;
> +	ELF_HASH_TYPE *bucket, *chain;
> +	ELF_HASH_TYPE nbucket, nchain;
>  
>  	/* Version table */
>  	ELF(Versym) *versym;
> @@ -131,7 +137,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
>  	/*
>  	 * Fish out the useful bits of the dynamic table.
>  	 */
> -	ELF(Word) *hash = 0;
> +	ELF_HASH_TYPE *hash = 0;
>  	vdso_info.symstrings = 0;
>  	vdso_info.symtab = 0;
>  	vdso_info.versym = 0;
> @@ -149,7 +155,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
>  				 + vdso_info.load_offset);
>  			break;
>  		case DT_HASH:
> -			hash = (ELF(Word) *)
> +			hash = (ELF_HASH_TYPE *)
>  				((uintptr_t)dyn[i].d_un.d_ptr
>  				 + vdso_info.load_offset);
>  			break;
> diff --git a/tools/testing/selftests/vDSO/vdso_test.c b/tools/testing/selftests/vDSO/vdso_test.c
> index 719d5a6bd664..2b21261a5eba 100644
> --- a/tools/testing/selftests/vDSO/vdso_test.c
> +++ b/tools/testing/selftests/vDSO/vdso_test.c
> @@ -22,11 +22,14 @@ extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
>  extern void vdso_init_from_auxv(void *auxv);
>  
>  /*
> - * ARM64's vDSO exports its gettimeofday() implementation with a different
> - * name and version from other architectures, so we need to handle it as
> - * a special case.
> + * Both ARM64's and s390x' vDSO exports its gettimeofday() implementation
> + * with a different name and version from other architectures, so we need
> + * to handle them as a special case.
>   */
> -#if defined(__aarch64__)
> +#if defined(__s390x__)
> +const char *version = "LINUX_2.6.29";
> +const char *name = "__kernel_gettimeofday";
> +#elif defined(__aarch64__)
>  const char *version = "LINUX_2.6.39";
>  const char *name = "__kernel_gettimeofday";
>  #else
> -- 
> 2.17.1
> 
