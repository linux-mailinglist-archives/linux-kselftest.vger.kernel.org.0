Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3964541396C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhIUSFC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 14:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231719AbhIUSFB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 14:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632247413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o2gyCGlUrboNcIiNieqE+IfjFr7udGGsuUiWMYUkrwc=;
        b=eqNExlImFOC7IvaOy4NfMdGeXMAax1qJO5Y/Z4cZjlg6iEda0JLDB5K7Foa076rlgCFSMY
        VOSDxEwbsXcRbbm3zCLBg5jAnC9e+MSboXGTNmi03Nsn+ncsTNCPwHpO0Q2ppW37tYmIyZ
        IStyvjjGSr8eH4j5IlDgTBAo6n6fc6Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-Y3qytb4iMgSxFQYZG2lRfQ-1; Tue, 21 Sep 2021 14:03:32 -0400
X-MC-Unique: Y3qytb4iMgSxFQYZG2lRfQ-1
Received: by mail-qk1-f197.google.com with SMTP id bk33-20020a05620a1a2100b00432fff50d40so108456500qkb.22
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 11:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o2gyCGlUrboNcIiNieqE+IfjFr7udGGsuUiWMYUkrwc=;
        b=ZIQUY/hry5es1GUlftVaxOVA3/It9fYcM1pB1tZWd3Di7KSGjkbag/jZ5LdPYCzVl/
         EXj/ypZdgPACrcmnSJpkEm6y8ylfrcLQTerIbch/FAJCcdfp4sTSHrJ9PB4z+ILcQxUn
         pw9X+N9rN6FhuqG1yW6zOdeiYg8ofxDbZTfQOBmJfr/bVJESP+p70TwPtRYG4xLzJeoe
         kmzh6CqPUX3osVVlRJQLY7lf+b999Hi0UpAIX/4uhRwni6PmgTTqMOY6ozDyUP2OpuOi
         3EHjFXvUrIJ7uhrg0Aiv0TNjHNqmzZe00bYi9Ba2jOSfKZ/Y+1d9+bgYMin3OyYOr5zC
         MyLw==
X-Gm-Message-State: AOAM530MSn6WR8N1/5PsykfhBPe/P/zgfhdyk3hPSQTCNQ/3JLpJFpSX
        opQcoqFXc3Dho/lBXrEmaPd+KP6UnS86ASqiHDTLvMik7XrVyT57jvWUMYkaivyCcqY7wsjApNW
        S4ZWJ0AjI1sLTxWmrXhp3WigpiUFH
X-Received: by 2002:ac8:4e11:: with SMTP id c17mr15690795qtw.400.1632247411185;
        Tue, 21 Sep 2021 11:03:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxa0LEMQ/1ArgdueEZqR3M76Qxk5uPrMK6duFpGckfUHr9iZTOK6FREBkxU98G4YICtISCcfg==
X-Received: by 2002:ac8:4e11:: with SMTP id c17mr15690771qtw.400.1632247410936;
        Tue, 21 Sep 2021 11:03:30 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id d5sm3792039qtr.61.2021.09.21.11.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:03:30 -0700 (PDT)
Date:   Tue, 21 Sep 2021 14:03:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] userfaultfd/selftests: don't rely on GNU extensions
 for random numbers
Message-ID: <YUoecZdcYBPLeejz@t490s>
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <20210921163323.944352-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921163323.944352-3-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 21, 2021 at 09:33:23AM -0700, Axel Rasmussen wrote:
> Two arguments for doing this:
> 
> First, and maybe most importantly, the resulting code is significantly
> shorter / simpler.
> 
> Then, we avoid using GNU libc extensions. Why does this matter? It makes
> testing userfaultfd with the selftest easier e.g. on distros which use
> something other than glibc (e.g., Alpine, which uses musl); basically,
> it makes the test more portable.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

