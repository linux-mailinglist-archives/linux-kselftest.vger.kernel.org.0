Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2300D7C276
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 14:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfGaM5l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 08:57:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33035 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfGaM5k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 08:57:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so69674009wru.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2019 05:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZf3ntVvlrIXripUKO5rZBanmNCibf9/L/ozsw4HA8o=;
        b=kO7tkZCX6nWuGPNIrT8Veqp38EzJXiwgIo4H/D0s7s46MDP885fDG+uY/+99iZ1tsz
         d7oQC4JwsqDwptTsE7/iBXCdqK25tHGR/tf0KYxerxDU6UNlF4C7bAsXzAmFskxk7omU
         HoHTPPmsPhdRLgH5f1YGALXoyHCV5yeg0hW9+cDqbMm3z/lLbrhgymN23ssuS/vbwqY9
         Z3md1SeQ/iUX2APyUH4/6gNMMwGDKy6CeYwFhPEr/pMxreKInk7rPNkyIF1apuzsW5DG
         Qr6wSRiGbk2pisbdjzArQYLc2NvKar3P+jOqOxt2dej13gjeGefzpFo0WGkNCuf0VLTS
         dHfg==
X-Gm-Message-State: APjAAAUB7XQ9dKaVOJqnZGS0ey7mRYgLTrXqHOE7z358wopCzo5gtlir
        RpxcJ5V7PX3NPGFPnPzekN7idg==
X-Google-Smtp-Source: APXvYqw7bOP3kc6TQ9IqEEedb7bS/T5LWV18de5oQMupwOl7c6btl9JW5t7pYEd70NAd/6Zc55OWqA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr41721246wrx.72.1564577858774;
        Wed, 31 Jul 2019 05:57:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3? ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
        by smtp.gmail.com with ESMTPSA id c1sm155407528wrh.1.2019.07.31.05.57.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 05:57:38 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: selftests: Implement ucall() for s390x
To:     Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-2-thuth@redhat.com>
 <20190730104807.7uzuvd52foybakgu@kamzik.brq.redhat.com>
 <d9cb3c86-6390-3803-f2c6-d47f5c24139f@redhat.com>
 <20190731102849.x26rdan7cddmpvhe@kamzik.brq.redhat.com>
 <0c38beb7-7383-a7ac-13d4-9d4bde4a21bb@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f7a103fa-51ef-533d-d3a4-7764fb742e44@redhat.com>
Date:   Wed, 31 Jul 2019 14:57:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0c38beb7-7383-a7ac-13d4-9d4bde4a21bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/07/19 13:16, Thomas Huth wrote:
> Or maybe even better: Let's move this file into lib/x86_64/ and
> lib/aarch64/ instead, since there is more different code between the
> architectures here than common code.

All good solutions, just choose one. :))

Paolo
