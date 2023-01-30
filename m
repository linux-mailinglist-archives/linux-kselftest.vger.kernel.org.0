Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C1680A50
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 11:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjA3KDe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 05:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjA3KDd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 05:03:33 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAF717CCB;
        Mon, 30 Jan 2023 02:03:32 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U8iKik030631;
        Mon, 30 Jan 2023 09:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7fprBaYwOOCmXuJOkAQ5QMZkawuxe6OxrvBklOkDwp4=;
 b=VT2OJCH83qwUtR2nCB+VoxZ35E9UGC8Uorro5rAVpYGEY6N2m41fldPyMCCp2rDQ7Unt
 PNYM14yEUWMdK5ekxNbf2nsTORIbqpKKisHiADdSUiXV9ocLIet0A15b/gJWd6+bXh1l
 Zee/VBYDLL+hUZIjsf/dC0ic37c7llZH0YE5/MnoZxq2X54Yd69nr1S3MlbIzFDuNg9i
 cltAJusmn8WRg7uUYw0xIiqW/M9/Fv4vl/eby0KD0CMTIP9zu//7aq96H3j3DhWTRx+L
 sr+aJTiULrZeSMehKeo2ic84cLkM36HsErlQXlCLpqMbRSGyT/gsyNA+/XU7k32NRyO2 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3neamygygs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 09:25:38 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30U8kCJR000988;
        Mon, 30 Jan 2023 09:25:38 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3neamygygc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 09:25:38 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30T3EN37011107;
        Mon, 30 Jan 2023 09:25:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ncvv69ee5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 09:25:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30U9PWUX42336590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 09:25:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7C4220043;
        Mon, 30 Jan 2023 09:25:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4514A20040;
        Mon, 30 Jan 2023 09:25:32 +0000 (GMT)
Received: from [9.171.8.15] (unknown [9.171.8.15])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 09:25:32 +0000 (GMT)
Message-ID: <0746a825-ca04-3746-a6ff-5289903a2843@linux.ibm.com>
Date:   Mon, 30 Jan 2023 10:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Huth <thuth@redhat.com>
References: <20230127174552.3370169-1-nsg@linux.ibm.com>
Content-Language: en-US
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [RFC PATCH v1] KVM: selftests: Compile s390 tests with -march=z10
In-Reply-To: <20230127174552.3370169-1-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vf_8CxvDOGmi9MSZ3bOC8w0-DH10hZoa
X-Proofpoint-GUID: ry1WlnRGW5T7WMJDlJyHDe1k9w7gI4iE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/27/23 18:45, Nina Schoetterl-Glausch wrote:
> The guest used in s390 kvm selftests is not be set up to handle all
> instructions the compiler might emit, i.e. vector instructions, leading
> to crashes.
> Limit what the compiler emits to the oldest machine model currently
> supported by Linux.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---

Technically it's a fix but as the tests have been running fine for years 
I'm inclined to put it into a full release rather than a fix rc.

Thanks for taking care of the fix:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> Should we also set -mtune?
> Since it are vector instructions that caused the problem here, there
> are some alternatives:
>   * use -mno-vx
>   * set the required guest control bit to enable vector instructions on
>     models supporting them
> 
> -march=z10 might prevent similar issues with other instructions, but I
> don't know if there actually exist other relevant instructions, so it
> could be needlessly restricting.
> 
> 
>   tools/testing/selftests/kvm/Makefile | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 1750f91dd936..df0989949eb5 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -200,6 +200,9 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>   	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
>   	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
>   	$(KHDR_INCLUDES)
> +ifeq ($(ARCH),s390)
> +	CFLAGS += -march=z10
> +endif
>   
>   no-pie-option := $(call try-run, echo 'int main(void) { return 0; }' | \
>           $(CC) -Werror $(CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)

