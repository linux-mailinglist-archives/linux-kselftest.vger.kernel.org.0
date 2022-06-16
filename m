Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05B254EFE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 05:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379488AbiFQDwj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 23:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379820AbiFQDwi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 23:52:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC911BB;
        Thu, 16 Jun 2022 20:52:30 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H2Il8n013995;
        Fri, 17 Jun 2022 03:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : in-reply-to : references : content-type : mime-version :
 date : content-transfer-encoding; s=pp1;
 bh=CXxs8+WhIUl3U8lU7Qeuh+7j6KZHP8StgkoSzdoFeqI=;
 b=glOV6CVsKdaWUcxk//dcNwKvPZhscAgrx4325MsfegJVeT6bmfjzUUiFz/NSoybN4PJB
 PyclC7vJGxNnl7LP1pYuiTJmbqV+kXQ3I8y+XkkmyJRD4hPYmboA3Ml/fnsTBYx+TPay
 rhEGmaWuY1KALBbBOJXAtaFu5rj3BNXJo8u6JXFug9A8U8wR8FM2FR5I7F3uYhOCo6eI
 LN/90YL+DpOu/bw837FGHkBWKtveRtzggWNhDm1J4sJ/fV6aeHjsB/fL1sP4cBRbaTIf
 D/tOmtcrcziSjGQtJgra+vSkH1xA8MCWbg16x655bPDG776OrPVrkK29+7+yBdo1tdq6 eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqw83xnp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 03:51:32 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25H3ZbrG017222;
        Fri, 17 Jun 2022 03:51:31 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqw83xnnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 03:51:31 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25H3p0lj020732;
        Fri, 17 Jun 2022 03:51:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3gmjp8xc6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 03:51:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25H3pRtJ18678188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 03:51:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 159174C046;
        Fri, 17 Jun 2022 03:51:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 982C74C040;
        Fri, 17 Jun 2022 03:51:25 +0000 (GMT)
Received: from sig-9-65-64-10.ibm.com (unknown [9.65.64.10])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jun 2022 03:51:25 +0000 (GMT)
Message-ID: <dba0cbb3e516ce715939be3638d2b5639608f2c1.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 1/2] selftests/kexec: remove broken EFI_VARS secure
 boot fallback check
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
In-Reply-To: <20220616124740.580708-2-ardb@kernel.org>
References: <20220616124740.580708-1-ardb@kernel.org>
         <20220616124740.580708-2-ardb@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Date:   Thu, 16 Jun 2022 14:08:56 -0400
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4InHe3smSIPxZBcxxyoelLs9sVfQeoNo
X-Proofpoint-ORIG-GUID: mKzpx9LRGCWb-ISX2aC0oL-oxHzRhU8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-17_02,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=947
 mlxscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170015
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-06-16 at 14:47 +0200, Ard Biesheuvel wrote:
> Commit b433a52aa28733e0 ("selftests/kexec: update get_secureboot_mode")
> refactored the code that discovers the EFI secure boot mode so it only
> depends on either the efivars pseudo filesystem or the efivars sysfs
> interface, but never both.
> 
> However, the latter version was not implemented correctly, given the
> fact that the local 'efi_vars' variable never assumes a value. This
> means the fallback has been dead code ever since it was introduced.
> 
> So let's drop the fallback altogether. The sysfs interface has been
> deprecated for ~10 years now, and is only enabled on x86 to begin with,
> so it is time to get rid of it entirely.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Thanks, Ard.

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

