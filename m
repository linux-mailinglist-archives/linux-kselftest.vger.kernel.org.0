Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CDA2311F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 20:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbgG1Ssj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 14:48:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729124AbgG1Ssj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 14:48:39 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SIX7C6151949;
        Tue, 28 Jul 2020 14:48:34 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jj2wnc4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 14:48:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SIkGDU012513;
        Tue, 28 Jul 2020 18:48:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 32gcqgm3ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 18:48:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06SImTHV32178480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 18:48:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7884AE04D;
        Tue, 28 Jul 2020 18:48:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB543AE051;
        Tue, 28 Jul 2020 18:48:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.76.171])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jul 2020 18:48:26 +0000 (GMT)
Message-ID: <fa96a33641070b1580f21de86fedd5f8da5eff21.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/19] Introduce partial kernel_read_file() support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Jul 2020 14:48:25 -0400
In-Reply-To: <1a46db6f-1c8a-3509-6371-7c77999833f2@broadcom.com>
References: <20200724213640.389191-1-keescook@chromium.org>
         <1595848589.4841.78.camel@kernel.org>
         <1a46db6f-1c8a-3509-6371-7c77999833f2@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_15:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280131
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2020-07-27 at 12:18 -0700, Scott Branden wrote:
> Hi Mimi/Kees,
> 
> On 2020-07-27 4:16 a.m., Mimi Zohar wrote:
> > On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> >> v3:
> >> - add reviews/acks
> >> - add "IMA: Add support for file reads without contents" patch
> >> - trim CC list, in case that's why vger ignored v2
> >> v2: [missing from lkml archives! (CC list too long?) repeating changes
> here]
> >> - fix issues in firmware test suite
> >> - add firmware partial read patches
> >> - various bug fixes/cleanups
> >> v1: 
> https://lore.kernel.org/lkml/20200717174309.1164575-1-keescook@chromium.org/
> >>
> >> Hi,
> >>
> >> Here's my tree for adding partial read support in kernel_read_file(),
> >> which fixes a number of issues along the way. It's got Scott's firmware
> >> and IMA patches ported and everything tests cleanly for me (even with
> >> CONFIG_IMA_APPRAISE=y).
> > Thanks, Kees.  Other than my comments on the new
> > security_kernel_post_load_data() hook, the patch set is really nice.
> >
> > In addition to compiling with CONFIG_IMA_APPRAISE enabled, have you
> > booted the kernel with the ima_policy=tcb?  The tcb policy will add
> > measurements to the IMA measurement list and extend the TPM with the
> > file or buffer data digest.  Are you seeing the firmware measurements,
> > in particular the partial read measurement?
> I booted the kernel with ima_policy=tcb.
> 
> Unfortunately after enabling the following, fw_run_tests.sh does not run.
> 
> mkdir /sys/kernel/security
> mount -t securityfs securityfs /sys/kernel/security
> echo "measure func=FIRMWARE_CHECK" > /sys/kernel/security/ima/policy
> echo "appraise func=FIRMWARE_CHECK appraise_type=imasig" >
> /sys/kernel/security/ima/policy
> ./fw_run_tests.sh
> 
> [ 1296.258052] test_firmware: loading 'test-firmware.bin'
> [ 1296.263903] misc test_firmware: loading /lib/firmware/test-firmware.bin
> failed with error -13
> [ 1296.263905] audit: type=1800 audit(1595905754.266:9): pid=5696 uid=0
> auid=4294967295 ses=4294967295 subj=kernel op=appraise_data cause=IMA-
> signature-required comm="fw_namespace" name="/lib/firmware/test-firmware.bin"
> dev="tmpfs" ino=4592 res=0
> [ 1296.297085] misc test_firmware: Direct firmware load for test-firmware.bin
> failed with error -13
> [ 1296.305947] test_firmware: load of 'test-firmware.bin' failed: -13

The "appraise" rule verifies the IMA signature.  Unless you signed the firmware
(evmctl) and load the public key on the IMA keyring, that's to be expected.  I
assume you are seeing firmware measurements in the IMA measuremenet log.

Mimi

