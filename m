Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AC31BB668
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Apr 2020 08:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1GVO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Apr 2020 02:21:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbgD1GVO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Apr 2020 02:21:14 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S63Cth143380;
        Tue, 28 Apr 2020 02:20:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mguvmxya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 02:20:59 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03S63EM4143427;
        Tue, 28 Apr 2020 02:20:58 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mguvmxxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 02:20:58 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03S6EQIv018731;
        Tue, 28 Apr 2020 06:20:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5nexn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 06:20:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03S6KsOC65339552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 06:20:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2038CA4040;
        Tue, 28 Apr 2020 06:20:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6E96A4051;
        Tue, 28 Apr 2020 06:20:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 28 Apr 2020 06:20:53 +0000 (GMT)
Date:   Tue, 28 Apr 2020 08:20:53 +0200
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     svens@stackframe.org, Thomas Gleixner <tglx@linutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/vDSO: prevent SIGFPE if vdso_info.nbucket
 is zero
Message-ID: <20200428062053.GA62357@tuxmaker.boeblingen.de.ibm.com>
References: <20200404203704.69412-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404203704.69412-1-svens@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_02:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280051
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 04, 2020 at 10:37:03PM +0200, Sven Schnelle wrote:
> If vdso_info can't be parsed correctly, vdso_info.nbucket might
> contain zero. Add a check and return NULL which will fail the
> symbol lookup.

Ping?

> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  tools/testing/selftests/vDSO/parse_vdso.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 1dbb4b87268f..8e5a70a24d9a 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -226,6 +226,9 @@ void *vdso_sym(const char *version, const char *name)
>  		return 0;
>  
>  	ver_hash = elf_hash(version);
> +	if (!vdso_info.nbucket)
> +		return NULL;
> +
>  	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
>  
>  	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
> -- 
> 2.17.1
> 
