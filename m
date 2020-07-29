Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065392322B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2Q3u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 12:29:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbgG2Q3u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 12:29:50 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06TG3DoH045938;
        Wed, 29 Jul 2020 12:29:45 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32k72bkbmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 12:29:44 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06TGMpQV031485;
        Wed, 29 Jul 2020 16:29:43 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 32gcqgn91e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 16:29:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06TGTel324510758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 16:29:40 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D26A5A4040;
        Wed, 29 Jul 2020 16:29:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75176A4051;
        Wed, 29 Jul 2020 16:29:37 +0000 (GMT)
Received: from sig-9-65-244-68.ibm.com (unknown [9.65.244.68])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jul 2020 16:29:37 +0000 (GMT)
Message-ID: <e5ed8876b9907315c2a906ab248639ea8c6d2cd5.camel@linux.ibm.com>
Subject: Re: [PATCH v3 12/19] firmware_loader: Use security_post_load_data()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 Jul 2020 12:29:36 -0400
In-Reply-To: <202007281242.B6016AE4B@keescook>
References: <20200724213640.389191-1-keescook@chromium.org>
         <20200724213640.389191-13-keescook@chromium.org>
         <1595847465.4841.63.camel@kernel.org> <202007281242.B6016AE4B@keescook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_10:2020-07-29,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=3 impostorscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290105
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2020-07-28 at 12:43 -0700, Kees Cook wrote:
> On Mon, Jul 27, 2020 at 06:57:45AM -0400, Mimi Zohar wrote:
> > On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> > > Now that security_post_load_data() is wired up, use it instead
> > > of the NULL file argument style of security_post_read_file(),
> > > and update the security_kernel_load_data() call to indicate that a
> > > security_kernel_post_load_data() call is expected.
> > > 
> > > Wire up the IMA check to match earlier logic. Perhaps a generalized
> > > change to ima_post_load_data() might look something like this:
> > > 
> > >     return process_buffer_measurement(buf, size,
> > >                                       kernel_load_data_id_str(load_id),
> > >                                       read_idmap[load_id] ?: FILE_CHECK,
> > >                                       0, NULL);
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > process_measurement() measures, verifies a file signature -  both
> > signatures stored as an xattr and as an appended buffer signature -
> > and augments audit records with the file hash. (Support for measuring,
> > augmenting audit records, and/or verifying fs-verity signatures has
> > yet to be added.)
> > 
> > As explained in my response to 11/19, the file descriptor provides the
> > file pathname associated with the buffer data.  In addition, IMA
> > policy rules may be defined in terms of other file descriptor info -
> > uid, euid, uuid, etc.
> > 
> > Recently support was added for measuring the kexec boot command line,
> > certificates being loaded onto a keyring, and blacklisted file hashes
> > (limited to appended signatures).  None of these buffers are signed.
> >  process_buffer_measurement() was added for this reason and as a
> > result is limited to just measuring the buffer data.
> > 
> > Whether process_measurement() or process_buffer_measurement() should
> > be modified, needs to be determined.  In either case to support the
> > init_module syscall, would at minimum require the associated file
> > pathname.
> 
> Right -- I don't intend to make changes to the init_module() syscall
> since it's deprecated, so this hook is more of a "fuller LSM coverage
> for old syscalls" addition.
> 
> IMA can happily continue to ignore it, which is what I have here, but I
> thought I'd at least show what it *might* look like. Perhaps BPF LSM is
> a better example.
> 
> Does anything need to change for this patch?

I wasn't aware that init_syscall was deprecated.  From your original comments,
it sounded like you wanted a new LSM for verifying kernel module signatures, as
they're currently supported via init_module().

I was mistaken.  Without a file descriptor, security_post_load_data() will
measure the firmware, as Scott confirmed, but won't be able to verify the
signature, whether he signed it using evmctl or not.

Mimi


