Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85123E3BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Aug 2020 00:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgHFWAI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Aug 2020 18:00:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4596 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbgHFWAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Aug 2020 18:00:08 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076LqDi5131695;
        Thu, 6 Aug 2020 17:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=cxTZzcb4aMf7WDm8Yvfasmnlo1/3FhGlzPTgL7YlmKQ=;
 b=o/dd2D3fn8snErUYFYK/U7j4E1/t8rQMpVd3xFKd6KrsGskjDKFdUD3LkHN53ADD+VnD
 dZu3aybdwPpgmRihyYL+6ywq0JpVZCZZMEYSxTgz4hk1vGhBt95YDoH+FqKLkMkwn8tm
 MhFVscsjgcMtSYBJj2ArF0dPEmV0rCVGbI/LkG7q8j2EBNlnx2gDL9DinKDBw/76sFFV
 P2NiFNTGuPxhehPsFXTP6alURkslAn9gMLbGz1VKWKMaZj8Y5nFXfRzbaZ1CIf9t0NJO
 js95XVm08yi1BvS/gpuuvavquEclE3ylnXuoN7tmx+lxtDOJ2J24zpPqeyvcmqDDvWep Lg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32rntyeq7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 17:59:59 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076LjouV026006;
        Thu, 6 Aug 2020 21:59:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 32n018bkby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 21:59:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 076LxrEC29295026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Aug 2020 21:59:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A80035204E;
        Thu,  6 Aug 2020 21:59:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.117.136])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8B43552051;
        Thu,  6 Aug 2020 21:59:50 +0000 (GMT)
Message-ID: <cd7e4fdabf563792d31bbcb8f6df6483570e7221.camel@linux.ibm.com>
Subject: Re: [PATCH v4 09/17] LSM: Introduce kernel_post_load_data() hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Aug 2020 17:59:46 -0400
In-Reply-To: <20200729175845.1745471-10-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
         <20200729175845.1745471-10-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_17:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060141
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-07-29 at 10:58 -0700, Kees Cook wrote:
> There are a few places in the kernel where LSMs would like to have
> visibility into the contents of a kernel buffer that has been loaded or
> read. While security_kernel_post_read_file() (which includes the
> buffer) exists as a pairing for security_kernel_read_file(), no such
> hook exists to pair with security_kernel_load_data().
> 
> Earlier proposals for just using security_kernel_post_read_file() with a
> NULL file argument were rejected (i.e. "file" should always be valid for
> the security_..._file hooks, but it appears at least one case was
> left in the kernel during earlier refactoring. (This will be fixed in
> a subsequent patch.)
> 
> Since not all cases of security_kernel_load_data() can have a single
> contiguous buffer made available to the LSM hook (e.g. kexec image
> segments are separately loaded), there needs to be a way for the LSM to
> reason about its expectations of the hook coverage. In order to handle
> this, add a "contents" argument to the "kernel_load_data" hook that
> indicates if the newly added "kernel_post_load_data" hook will be called
> with the full contents once loaded. That way, LSMs requiring full contents
> can choose to unilaterally reject "kernel_load_data" with contents=false
> (which is effectively the existing hook coverage), but when contents=true
> they can allow it and later evaluate the "kernel_post_load_data" hook
> once the buffer is loaded.
> 
> With this change, LSMs can gain coverage over non-file-backed data loads
> (e.g. init_module(2) and firmware userspace helper), which will happen
> in subsequent patches.
> 
> Additionally prepare IMA to start processing these cases.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks, Kees.   Other than a missing "name" field, it looks good.

The security_kernel_post_load_data hook may be used to verify appended
signatures and to measure the buffer data.  Passing the kernel module
(load_info.name) and firmware (fw_name) names is critical at least for
IMA-measurement.

thanks,

Mimi

