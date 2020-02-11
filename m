Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9884159BDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 23:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBKWBp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 17:01:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43667 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBKWBo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 17:01:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id p11so86396plq.10
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 14:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKZr9Nn9oPrGK2xfIwGCJXtf9vPWAVskjBr9vetGONI=;
        b=XwXVHgHM2emkQEfI9tLsLCP17GoUihqbxlKF04GFa8syindlYGF6luInOgl9iJ2/SS
         FCuP2FrjYOa4vYDvAKkApoQt3tqw6v27yFnaUuo2FZbWbsxUebIyTZ2SyvQ4blQ4P6Nd
         UDpbPF+Wn1yRm86qcHQQwE6Lhzm+GtV71YILUdaQnD9ureO5q821PnZ0+zmp9zc3LZM3
         Rl0HV9kXJOEEufifX8Qk/vnKBPpl6jH5Llf/BZF2IMH12MtUkmEjhOsOIFZjWwU+R70J
         nqBpfeVFkLB0LoDPlHVHH5/WNPsNNYqslHgKeXp+o8ICblmT8PwZpaWNxgxO50IuLpnX
         tsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKZr9Nn9oPrGK2xfIwGCJXtf9vPWAVskjBr9vetGONI=;
        b=KKbuQHlRhMkNkv1jILqVzXlVGHM2GuiY3RmjsFaE9Dv3CgHMyl4XyKONTgDLTkqsyU
         O0aN084DKDPdgr/i7BJfKJ8xLOyubXPQ+ctsS2DnL0iNIm0c/BTgU6rlxqZXibBbQoyC
         cLLgMo41ndg8h6bZdFdfBVR1p8yHzIQ2JEqWC6tLTeAkyGkirIyvv1LVBG6PUk5DvvOG
         9Mmbi98iCcZEbgnbODifrSa+tJ1udxVQZRYcVGMQHZ83zQqXVorYKNtwsV0mYf4REndY
         8FKiYR+gDlRO21wCnx2JSQTzpgpVFJO3DYqZ4gXBUV7mtleL/uRbHoPcHFhbKYuJD13x
         EEWQ==
X-Gm-Message-State: APjAAAWNWLT7TyXrSDPX9PD3m1B1jVJDEU5y0PQouCOPD/nrx9JMRqD7
        ld0o1zhgUKMArzr1YgbIok/VzXoDJamnneSBiwjk2A==
X-Google-Smtp-Source: APXvYqxiyp8ZPewy/3SdNtAOX/zkfxDTYqfVAUM5KyHWCmZSU/tv3ddASBVflxRQ8siqw0nVjWdgoYsNWCnV2WD8RNs=
X-Received: by 2002:a17:90a:6c26:: with SMTP id x35mr5717606pjj.84.1581458502683;
 Tue, 11 Feb 2020 14:01:42 -0800 (PST)
MIME-Version: 1.0
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com> <1581094694-6513-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1581094694-6513-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Feb 2020 14:01:31 -0800
Message-ID: <CAFd5g471GgE=Ebb5QMnWZz0Gjswu5mfTJe=e8kDcLudTG2rcRQ@mail.gmail.com>
Subject: Re: [PATCH v3 kunit-next 2/2] kunit: update documentation to describe
 debugfs representation
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 7, 2020 at 8:59 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Documentation should describe debugfs layout and semantics.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
