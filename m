Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C0D2BE9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 07:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfE1FeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 01:34:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbfE1FeF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 01:34:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4S5RdVP017186
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2019 01:34:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2srxuy0cds-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2019 01:34:03 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 28 May 2019 06:34:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 May 2019 06:33:59 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4S5Xwa963176916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 05:33:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 150A511C070;
        Tue, 28 May 2019 05:33:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7345F11C077;
        Tue, 28 May 2019 05:33:57 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.53])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 May 2019 05:33:57 +0000 (GMT)
Date:   Tue, 28 May 2019 08:33:55 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Alakesh Haloi <alakesh.haloi@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] userfaultfd: selftest: fix compiler warning
References: <20190527151859.GA3217@ip-172-31-44-144.us-west-2.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190527151859.GA3217@ip-172-31-44-144.us-west-2.compute.internal>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19052805-0008-0000-0000-000002EB13DF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052805-0009-0000-0000-00002257DEF8
Message-Id: <20190528053355.GB5055@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280038
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 27, 2019 at 03:18:59PM +0000, Alakesh Haloi wrote:
> Fixes following compiler warning
> 
> userfaultfd.c: In function ‘usage’:
> userfaultfd.c:126:2: warning: format not a string literal and no format
> 	arguments [-Wformat-security]
>   fprintf(stderr, examples);
> 
> Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  tools/testing/selftests/vm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 5d1db824f73a..b3e6497b080c 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -123,7 +123,7 @@ static void usage(void)
>  	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
>  		"hugetlb_shared, shmem\n\n");
>  	fprintf(stderr, "Examples:\n\n");
> -	fprintf(stderr, examples);
> +	fprintf(stderr, "%s", examples);
>  	exit(1);
>  }
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

