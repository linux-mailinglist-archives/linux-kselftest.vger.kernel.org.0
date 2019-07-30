Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4353D7A70D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2019 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfG3LfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jul 2019 07:35:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55827 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfG3LfZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jul 2019 07:35:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so56813009wmj.5
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2019 04:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y244Xl4lre8/Rj1RhE87snrTTBEmuS8COkuSeU6uG1M=;
        b=CcBVfZAwLakK695yukVbG5b3MDDc4Gi2AOdPLw4Rr3tXmbsSiKR37CW6DZaaPiBl1k
         yB1fVpYeGczbzOIImroDF53B7TyTB3hznLDQA8VqKkRDUqjzIQ7btkdJeIiNkej7Clb+
         SrxtLR/crWcNBEbe8AuIzX1m72BxzQFMgjBAWWrt4HNqyr7DPoCYg7qQtWJSr/3YP1/4
         3CPpS8eiCxs7xYpp93B6J/wOhnDrumK7713ao8l758vsf+Hx7jgCS6VWn6tcP7WmdEkK
         +vLAMWKjY3zO8bN/cljcBBr5kC4axYBKLOLWW7fuzMz09YJ+lTneBIpWpLHus3yIZ1sI
         89NA==
X-Gm-Message-State: APjAAAUtjBdsupZh4euDrLiKc7oV3bfIOBimaxNQtYWDX241EZ7W+Dwe
        U0G7ojjcJcrFeZLl9mopBw54hw==
X-Google-Smtp-Source: APXvYqzkH9Q1Qg/qmKmzEMbzb79yFSlC2/AlPs26tGR5Hv2Po5wEl1eHp6jRHjCYU18erlFW03Sryg==
X-Received: by 2002:a1c:4e14:: with SMTP id g20mr28937377wmh.3.1564486523302;
        Tue, 30 Jul 2019 04:35:23 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id s10sm72854605wmf.8.2019.07.30.04.35.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 04:35:22 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3092bab6-8ab9-c404-a5bb-64ca89eccd12@redhat.com>
Date:   Tue, 30 Jul 2019 13:35:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730100112.18205-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30/07/19 12:01, Thomas Huth wrote:
> +#ifdef __s390x__
> +	/*
> +	 * On s390x, all pages of a 1M segment are initially marked as dirty
> +	 * when a page of the segment is written to for the very first time.
> +	 * To compensate this specialty in this test, we need to touch all
> +	 * pages during the first iteration.
> +	 */
> +	for (i = 0; i < guest_num_pages; i++) {
> +		addr = guest_test_virt_mem + i * guest_page_size;
> +		*(uint64_t *)addr = READ_ONCE(iteration);
> +	}
> +#endif

Go ahead and make this unconditional.

Paolo
