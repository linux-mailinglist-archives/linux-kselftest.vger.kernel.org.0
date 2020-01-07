Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27E6132AB2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 17:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAGQEJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 11:04:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28503 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727974AbgAGQEJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 11:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578413048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6/pI4t6B9z0wRX+NvUB89xIHygZ7s0TFKH3LWLJINv4=;
        b=glV97bbJAGPgV+M2Z2fZhusGO2pk1Tpa3fpFcZweCUliJCFYkYztEkHU0u84/EuJ+6Hxhz
        kVerEg3TwknY9k4ypTB00idi937GZyxMHliG2gqdoNYKg9H3TC4LAg+WqJTh+wop/ubgPQ
        IY3I2qiC4Atp+vBWE07Y3WauqRBzpcc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-PeuYcUtiNuOu45p-5BzrBA-1; Tue, 07 Jan 2020 11:04:07 -0500
X-MC-Unique: PeuYcUtiNuOu45p-5BzrBA-1
Received: by mail-qk1-f197.google.com with SMTP id 143so82645qkg.12
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2020 08:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/pI4t6B9z0wRX+NvUB89xIHygZ7s0TFKH3LWLJINv4=;
        b=U2uHaiyR9Eu7HZWTlszvoqWC+nbKQ1MMGT3sz6ficHqD7x9GFlbBX1SrtFpxCkm99t
         qPuUvpLfNzu8K/+BKfZI/X/jBiY5LQHIM0uMlBN16ReFhlT60QfkvtJw5Hiq+RdBVB84
         bH7NHYaq2qR+ROCwCTy/wfYRuwX+eWID/3XQPb3WXoR82lLOjESfpQkQX6jSvx4FANCv
         nF5tg8l8Eqyq3rBdS4/J9F2Kn97YHEJvbDGLoptlaFgByo2DYzh1U53HzFrrsMLs2QUw
         qA7IG5CcjsI0CCLHWiflNfrvjnmOPUO3eKveX28LVnfYDhyvIJ1H/Jh0H1N5nuu0ekyN
         SGMw==
X-Gm-Message-State: APjAAAWdn9Gkdj9PqEu2LNfk1J2o7NHpHN9ah/P13Y9p5QjxGQckevJf
        58Bz3xNp0RkgSLitw+TiLqxr+YwW9jTtR667AbSBKBVcwIutrWYRgXfCHoHr9nmvd5YThLYlRNZ
        3kEeOVIWaHCgqk9dYOyNR5I+l1jyP
X-Received: by 2002:aed:2d67:: with SMTP id h94mr78673823qtd.74.1578413046804;
        Tue, 07 Jan 2020 08:04:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqw66uIFnVme9AqF60F5anI9TjXT0ppMeOA6QoIMEfNwjdJGOKZ3GP3xMn0fUgfQqx9ibtRZXQ==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr78673801qtd.74.1578413046612;
        Tue, 07 Jan 2020 08:04:06 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id k50sm47999qtc.90.2020.01.07.08.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:04:05 -0800 (PST)
Date:   Tue, 7 Jan 2020 11:04:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Add configurable demand paging
 delay
Message-ID: <20200107160404.GH219677@xz-x1>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-4-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216213901.106941-4-bgardon@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 16, 2019 at 01:38:56PM -0800, Ben Gardon wrote:
> When running the demand paging test with the -u option, the User Fault
> FD handler essentially adds an arbitrary delay to page fault resolution.
> To enable better simulation of a real demand paging scenario, add a
> configurable delay to the UFFD handler.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

