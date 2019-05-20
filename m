Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB12322B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2019 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbfETLUG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 07:20:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34262 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732628AbfETLUG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 07:20:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so7748537wrt.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2019 04:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f4Ug1MrEqipFcsXWDEaXY+h36JBhOVj9TAD4XBLpsmg=;
        b=HwHS99UtXP4OxqWPAz+ZyYI8I6rIevZZl5NW+p5aa/sK4IaNgOXC6bI/1MPCUGZqjP
         koHJaeJdH6Ev/P17Dh9pB5lmSqmbrf36wUo5SiAtJ13y1e26oBHO4BCGVrQIeTiOr1xq
         GVmwuVv/6OAafV+uzqEapSerLjKpnvjo6znsRtxoPPvxol6Wcfw57jHtVb9zhMGDjSRO
         eWd62GHwqmo2zAB69LwBpqCdF3QuKu8MCddYSj8JtfyHSTC9LjMBnzDtFE25Nr6BLbnb
         7zwwayvti0qI6sjZ+AkS8RDdqTvEwxMUKj6DnHGSvwEM3GgJqHZBwPaonZt99DDLzPtO
         WzOA==
X-Gm-Message-State: APjAAAUPX5BQtuuqctpJl3SY89Mghn8QXh0hCQAZLPsPYZbpie1+yDYO
        QW3ZWtBAyIb5SMpRmHbn/324Tg==
X-Google-Smtp-Source: APXvYqythDnG05R24/GCVku939OLV2V+hp8o445FMzheQB00gWCVpDRQZJzknTi/GPq603//Mn3fFg==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr34566267wrt.96.1558351204927;
        Mon, 20 May 2019 04:20:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id e2sm12948704wme.32.2019.05.20.04.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 04:20:04 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] KVM selftests for s390x
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20190516111253.4494-1-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b412e591-3983-ebef-510b-43f9b7be4147@redhat.com>
Date:   Mon, 20 May 2019 13:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516111253.4494-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16/05/19 13:12, Thomas Huth wrote:
> This patch series enables the KVM selftests for s390x. As a first
> test, the sync_regs from x86 has been adapted to s390x.
> 
> Please note that the ucall() interface is not used yet - since
> s390x neither has PIO nor MMIO, this needs some more work first
> before it becomes usable (we likely should use a DIAG hypercall
> here, which is what the sync_reg test is currently using, too...).

No objections at all, though it would be like to have ucall plumbed in
from the beginning.

Paolo
