Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC81B7AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2019 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfEMODG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 May 2019 10:03:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:32847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbfEMODG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 May 2019 10:03:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 07:03:05 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga003.jf.intel.com with ESMTP; 13 May 2019 07:03:05 -0700
Date:   Mon, 13 May 2019 07:03:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     shuah@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] selftests: kvm: Add files generated when compiled to
 .gitignore
Message-ID: <20190513140305.GA28561@linux.intel.com>
References: <5d60e7126803e9a11b51618e65966ba047eff7df>
 <20190512044434.32627-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512044434.32627-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 11, 2019 at 10:44:34PM -0600, Kelsey Skunberg wrote:
> The following files are generated in /selftests/kvm/ after compiling and
> should be added to /selftests/kvm/.gitignore:
> 
>         - /x86_64/hyperv_cpuid
> 	- /x86_64/smm_test
> 	- /clear_dirty_log_test
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---

An equivalent patch has already been queued.

https://patchwork.kernel.org/patch/10931115/

> Changes since v1:
>         - Included /clear_dirty_log_test to .gitignore
>         - Updated commit log to reflect file added
> 
>  tools/testing/selftests/kvm/.gitignore | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 2689d1ea6d7a..391a19231618 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -6,4 +6,7 @@
>  /x86_64/vmx_close_while_nested_test
>  /x86_64/vmx_tsc_adjust_test
>  /x86_64/state_test
> +/x86_64/hyperv_cpuid
> +/x86_64/smm_test
> +/clear_dirty_log_test
>  /dirty_log_test
> --
> 2.20.1
> 
