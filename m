Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7B7C9B58
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 12:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfJCKAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Oct 2019 06:00:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbfJCKAs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Oct 2019 06:00:48 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63FCD2A41
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2019 10:00:48 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id g67so482268wmg.4
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2019 03:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j4Sd4Y4ZJrOTf0nQAt0dRSPWuAZd0kaqiXKDLBQk1w4=;
        b=KqW4GvRPwro6XFE6QCLrwHHrf+R7iMRqLibrrImSUmZ1Nc59eMUV0BPE/g9ZkoP/wW
         mLCkqPeH8sa9lbbE/LHxWTSj0URM6cC8du/a/ZfGKlqMS+LSPmJzONXcIBGalmqLnnlr
         5mdJgKy3xzYSHbW7TNu7jNMzY4lx4VAGsJwu2NzFyjzCtKuKGBbvCXn+YL+Kxl2X4/fy
         CnqugBOkLmlbfCQM6RgWn0Mq7ZC4AjK28FIENQoHy+uEvVlskuK2zt+WG3nOtqtVfE/p
         sVYu7q2Oom3UlCJCJrjQSfObpa53IC+viKYS0WgdfZXoRWL1QAwR49XVROhuQK0aSvdI
         95dg==
X-Gm-Message-State: APjAAAVY6Zy2swJgZv6xxM+Ob0Ocb3RqV74R74kKLr2YcPOMTlSqdJl+
        me0lh163SrSPOEbdYFOrYZyq3sJNE7cd2o9vfuNJAF/aZZanUD+V3XAw+oCa6iHB59J0gRV/SWr
        08V9kzCPCWrQpMczuVMeedvOpvy8T
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr6273518wru.89.1570096847043;
        Thu, 03 Oct 2019 03:00:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx43Qbh0FZwMiSJLnAcybiyT39Q5fJhZPWfbU32Il+ItDqqHxpKQvd2OQb8SRTwGnd1gMfFyA==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr6273499wru.89.1570096846686;
        Thu, 03 Oct 2019 03:00:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464? ([2001:b07:6468:f312:b903:6d6f:a447:e464])
        by smtp.gmail.com with ESMTPSA id l4sm2567905wrw.6.2019.10.03.03.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 03:00:45 -0700 (PDT)
Subject: Re: [PATCH v3] selftests: kvm: Fix libkvm build error
To:     Shuah Khan <skhan@linuxfoundation.org>, rkrcmar@redhat.com,
        shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191002231430.5839-1-skhan@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4b46d043-9990-e95a-2665-a9382af1f723@redhat.com>
Date:   Thu, 3 Oct 2019 12:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002231430.5839-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/10/19 01:14, Shuah Khan wrote:
> Fix the following build error from "make TARGETS=kvm kselftest":
> 
> libkvm.a(assert.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIC
> 
> This error is seen when build is done from the main Makefile using
> kselftest target. In this case KBUILD_CPPFLAGS and CC_OPTION_CFLAGS
> are defined.
> 
> When build is invoked using:
> 
> "make -C tools/testing/selftests/kvm" KBUILD_CPPFLAGS and CC_OPTION_CFLAGS
> aren't defined.
> 
> There is no need to pass in KBUILD_CPPFLAGS and CC_OPTION_CFLAGS for the
> check to determine if --no-pie is necessary, which is the case when these
> two aren't defined when "make -C tools/testing/selftests/kvm" runs.
> 
> Fix it by simplifying the no-pie-option logic. With this change, both
> build variations work.
> 
> "make TARGETS=kvm kselftest"
> "make -C tools/testing/selftests/kvm"
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v2:
> -- Removed extra blank line added by accident.
> -- Fixed commit log.
> 
>  tools/testing/selftests/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 62c591f87dab..7ee097658ef0 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -48,7 +48,7 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>  	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
>  
>  no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
> -        $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
> +        $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
>  
>  # On s390, build the testcases KVM-enabled
>  pgste-option = $(call try-run, echo 'int main() { return 0; }' | \
> 

Queued, thanks.

Paolo
