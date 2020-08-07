Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C4523E51B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Aug 2020 02:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHGAYN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Aug 2020 20:24:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgHGAYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Aug 2020 20:24:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077038jc175593;
        Thu, 6 Aug 2020 20:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VsXvvS8VKmxXDht3q36Bubq+Zar3OcXZnhZAUZMQcnY=;
 b=osQlR8ck1rT5G162TuDnpSNrxODRJG3dxpkrNZqQCF2Cdp6JuubIveeoPTy+njFJIIe2
 D3MnSivYKh0I7ddKP5/HThN1K6l1LBTV37g0Nd9xv34NNSj2oHOPAnv4k2FSMck0UGG7
 Ro+ZwjFZYrRiTK0BDmljRTm1B3xzO00Ceu0PoXfamHku+958QyF+MTyLzsWUgvdJk7t3
 FmajTb+ccilDljclikn5Bm8ybta2w/Zx7xXKYHR2bswT72i1k9FkUGXsFQolYrk2gAEW
 ltYbBrvJSVQ0yEO8zoDDiYosFvmdbWSzy+F6beREbwYkci4JLqcbiz4vwt1OkMUT+Xm+ UQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32rgnfn7rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 20:24:00 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0770Jqde005199;
        Fri, 7 Aug 2020 00:23:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 32n0185yyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 00:23:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0770NuNi28246380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Aug 2020 00:23:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F04DB4C04E;
        Fri,  7 Aug 2020 00:23:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B2EB4C046;
        Fri,  7 Aug 2020 00:23:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.117.136])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Aug 2020 00:23:52 +0000 (GMT)
Message-ID: <1cdddf80e0b1ea46346edf8a1c0dc81aea095f15.camel@linux.ibm.com>
Subject: Re: [PATCH v4 12/17] LSM: Add "contents" flag to kernel_read_file
 hook
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
Date:   Thu, 06 Aug 2020 20:23:51 -0400
In-Reply-To: <20200729175845.1745471-13-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
         <20200729175845.1745471-13-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_17:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060156
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-07-29 at 10:58 -0700, Kees Cook wrote:
> As with the kernel_load_data LSM hook, add a "contents" flag to the
> kernel_read_file LSM hook that indicates whether the LSM can expect
> a matching call to the kernel_post_read_file LSM hook with the full
> contents of the file. With the coming addition of partial file read
> support for kernel_read_file*() API, the LSM will no longer be able
> to always see the entire contents of a file during the read calls.
> 
> For cases where the LSM must read examine the complete file contents,
> it will need to do so on its own every time the kernel_read_file
> hook is called with contents=false (or reject such cases). Adjust all
> existing LSMs to retain existing behavior.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

