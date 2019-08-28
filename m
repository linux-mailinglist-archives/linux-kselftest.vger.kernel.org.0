Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E68A0E68
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 01:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfH1XoZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 19:44:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34015 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfH1XoZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 19:44:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so559065pgc.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 16:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v+7Vi0K+7iSjD64GjXiDvUOi+ZQN8cBfyBO0kWUqTAo=;
        b=lF/ZY7bIW43kPygO0eYojMdmyC7EdSWTlC9x4AJsKje+Nph5f5KWl56qJUptdakavf
         3+VDYA9HoxjM2CxX7RveAOQ6cYpyLK7PcCGUnKa9xcsEa9/CsVN0BL9Hxe3VXpvggtia
         fXrDMrD7JO7Zraw6pd2yZtpnDgWouvtCHOO9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v+7Vi0K+7iSjD64GjXiDvUOi+ZQN8cBfyBO0kWUqTAo=;
        b=nVzzIJ+FMSpIqC/rNe0el/Jv/VQzyWpYXsg5NSLu3AwuNmGuSjt8X7gwa4nWtSEA1y
         yGFs+g4x+yR0XLKCh2qsWrSrvgjMRiSWnVMA7psxUcZUaTj9kS051DB8xMsvW1VKKfZY
         wtEiWZhNlSiCZtYX7prD2b4++LX5TbmhX83aNoR6omyh+EsKWDftNRK0QI6ZRtSme8uu
         jJr/zqb5N/mnv08SPJgBEY9szFfAIwKYByixV5c2Qhuv8Gp3RDbU9/7FPJTA01XboDTv
         HjGHVcqFWZYDqZOEIpTMsYELA8Ek2IiqETI+8fzKAhjIlpB461kHwHXDH3wZtz6yatZN
         zpmg==
X-Gm-Message-State: APjAAAXUyYX373fNY89xVIH2QcoglcvCP0NGZQjNZap2gkfebk8mQvdm
        ynbwG2uTVfRxF9eufiA0P1uVsg==
X-Google-Smtp-Source: APXvYqxxx4925TvYESBbl7jTNbgz0DAnFrfbfZvXEyhrWpWa33PYoRop2V/NoIg6VNwG32B8ZouAmQ==
X-Received: by 2002:a63:3dcd:: with SMTP id k196mr5739639pga.45.1567035864264;
        Wed, 28 Aug 2019 16:44:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t4sm586675pfq.153.2019.08.28.16.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 16:44:23 -0700 (PDT)
Date:   Wed, 28 Aug 2019 16:44:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, me@carlosedp.com
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
Message-ID: <201908281643.1B89EB1E6@keescook>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
 <201908251451.73C6812E8@keescook>
 <CAEn-LToB1atxDvehBanVaxg6sk8zDkMe_CbqeTVgKNzOvD9-Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEn-LToB1atxDvehBanVaxg6sk8zDkMe_CbqeTVgKNzOvD9-Sw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 28, 2019 at 02:37:34PM -0700, David Abdurachmanov wrote:
>     --disk path=$PWD/disk \
>     --boot kernel=$PWD/${FIRMWARE} \

This is where I tripped over things. How do I specify the kernel to boot
from OUTSIDE the disk image?

-- 
Kees Cook
