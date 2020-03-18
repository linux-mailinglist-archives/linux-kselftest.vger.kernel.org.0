Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E61189CAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Mar 2020 14:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCRNNn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Mar 2020 09:13:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25624 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbgCRNNm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Mar 2020 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584537221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxBoqIBbe7s8BPyTsCZ02RzESp7E1oZC6kxy/vfpBRo=;
        b=ODsBolDURrG3BqnfW4yy0khAwv1hqx65glxBLG8PfjzWpxnDOJMfs7pVJs7+odzQNsZout
        R5n1WvlUbwoJ5oQX6+dmWH8xbthAkWI8RBRINx8RIQW46zNL+GsueyeIIanTDnSqkE/4B0
        Zm8YymEbVZkIgDYg0oiMDtN4xcH9hZA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-gsdpl-cuNcaZx3lsF98a6Q-1; Wed, 18 Mar 2020 09:13:40 -0400
X-MC-Unique: gsdpl-cuNcaZx3lsF98a6Q-1
Received: by mail-wm1-f69.google.com with SMTP id n188so1081591wmf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Mar 2020 06:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PxBoqIBbe7s8BPyTsCZ02RzESp7E1oZC6kxy/vfpBRo=;
        b=FYJXfMmWUyJbEfzr5EHfa9sfA49h3CkHsDLrbNS+9sDlYAKyKXuaqgZAxGSmc9fIgp
         gqNh7bDxgnmBIx47ILz6ueZUPi7+dkSQrRS3MdtDpY5bEoUPYdxZuaPRxlsmw5I3CgS1
         lvCxKa8U/jUbmBY9V98YkGQGakE2T+u5i4n/wVpKzsrsuq/xEhcN8f5dXUm7vGdbpJpN
         HGTOscPp5xjGaLlm7T9tuqYJJZXf1A7+fAkgtG+T+FZDlXoifiZQhgTRFOVgvH2vOaOM
         nY0OrJTVtkw+hGUIJSTQ7SWKMfZqTFU/1LxcPKgrcQUcQ51OAn1vUIH7r9HlmphxDD/J
         WHWA==
X-Gm-Message-State: ANhLgQ1r04KtLrsBzBYd0UHc8PmNFuXk4+Kkbp2XPtVy5EMWbMVSbgHe
        NyMzTrPOVRVe68P1dBTktvmjoEv5pL7bVBFAt6FTITAfEdelR8hsZhTdkTSrg1IrnJrOuUO7kSo
        /d8R+JZaJo2qo8n6M5sy6SnQjwFkL
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr5126516wmk.131.1584537218884;
        Wed, 18 Mar 2020 06:13:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs+9a05PJ9MjSVvgvmjIy/7AfVl4jvUgyfkQTDqBDQ0QhqKsWXVBZhmLJxegqv36zeZ+Qbawg==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr5126491wmk.131.1584537218610;
        Wed, 18 Mar 2020 06:13:38 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id n186sm3807573wme.25.2020.03.18.06.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 06:13:38 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix errors when try to build kvm selftests on
To:     Xiaoyao Li <xiaoyao.li@intel.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200315093425.33600-1-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f7a2945-300d-d62c-e5f5-de55c2e3fd2f@redhat.com>
Date:   Wed, 18 Mar 2020 14:13:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315093425.33600-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15/03/20 10:34, Xiaoyao Li wrote:
> I attempted to build KVM selftests on a specified dir, unfortunately
> neither	"make O=~/mydir TARGETS=kvm" in tools/testing/selftests, nor
> "make OUTPUT=~/mydir" in tools/testing/selftests/kvm work.
> 
> This series aims to make both work.
> 
> Xiaoyao Li (2):
>   kvm: selftests: Fix no directory error when OUTPUT specified
>   selftests: export INSTALL_HDR_PATH if using "O" to specify output dir
> 
>  tools/testing/selftests/Makefile     | 6 +++++-
>  tools/testing/selftests/kvm/Makefile | 3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

Queued, thanks.

Paolo

