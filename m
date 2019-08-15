Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636E18E5D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2019 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfHOH6M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Aug 2019 03:58:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39066 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfHOH6M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Aug 2019 03:58:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id x3so1090850lfn.6
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2019 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnRbLL/LwcVbEhMPr3jh4hj3/IFBTWKQ7hQtkYbtm+Q=;
        b=pqEb3j5BXKs3Sa7gN2Wbkf6RpXszqoFScxLyvNGkR11jYA9kGdfZXG+HlUdgQKNnWG
         q5ejtmml9Bar7HZ2m4nlqH/1j8wQ56NxmQLyYuXCAUx+UoO5Pkij4DM0QKdXYuuplshD
         ddaVz0LpMwJg+x8PZh3wxZ2SgP9x3kWZbv/QjJFUFf08rAMip5CtECO0QYH8bRlUTloR
         t8QHj4YJHhwVt+wD9d2aERGbsMu4xYYoVYwToRTLf6vK5O/U3t4bPcBqR7O2Fkdq7paQ
         2GaFJ7ild8BjYuMdvsgqBS2/XEVm/9RyIOnye/VsSMrcyaUXjJprtVKSnNiRofmPmMm+
         jDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnRbLL/LwcVbEhMPr3jh4hj3/IFBTWKQ7hQtkYbtm+Q=;
        b=dW9A/ktBUaIZ10DH69/V9XMjrBfTdMocE5j2RoS/iasVcPbabn74PDUSTrx4HRUKm+
         lPeBi92iyymsbcvi2XSL81TUT2HbjxgwNCJ1CcxNCphRuNq3fkUfXlg0snHlH0HP95WD
         Ivqh4Qb5xOpFAP2wiAUOLmGcyt47gJJcNEjnY0Fr7McrO1Orj9lDaSmFKyYiEVv2aXjY
         xevQVLf/6/9Y47MU61g+d5ayfMI3RF4Sci/Gd/hENQGnZ3uehKtAtg0adZovhvqgYl4z
         C8mlPzGSYzm6yCxeTKgm5Yj2bl4z4Lros8UlETCMXZm2uWIArdU7Tc2+YBJbhHWlVlQi
         cj9A==
X-Gm-Message-State: APjAAAVmhs1hS3PSvS/m4z60UgGyT9u7Q0OoawHknlJ9xmnpyqh5dFhN
        ho88lwQfEJ9VcRlCnDXBGUvvq6UmYxXJTEWvywJT7CK7
X-Google-Smtp-Source: APXvYqwMAF8mRtAvZKZai+/e8vMST+bOSfBJcWGHSL0RwdDxNeOQRlQgjseHs33+eHbShwhHpOhbSbBaw131Y8zhFMA=
X-Received: by 2002:a19:4c57:: with SMTP id z84mr1736285lfa.87.1565855889359;
 Thu, 15 Aug 2019 00:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190814214948.5571-1-anders.roxell@linaro.org> <ECADFF3FD767C149AD96A924E7EA6EAF977A2939@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977A2939@USCULXMSG01.am.sony.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 15 Aug 2019 09:57:58 +0200
Message-ID: <CADYN=9JuC_+MJEL36ScK1=yC3Qmo2zaMsNMLKHPjqBR1RKQMAA@mail.gmail.com>
Subject: Re: [PATCH] selftests: net: tcp_fastopen_backup_key.sh: fix
 shellcheck issue
To:     Tim.Bird@sony.com
Cc:     David Miller <davem@davemloft.net>, Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 15 Aug 2019 at 01:35, <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Anders Roxell
> >
> > When running tcp_fastopen_backup_key.sh the following issue was seen in
> > a busybox environment.
> > ./tcp_fastopen_backup_key.sh: line 33: [: -ne: unary operator expected
> >
> > Shellcheck showed the following issue.
> > $ shellcheck tools/testing/selftests/net/tcp_fastopen_backup_key.sh
> >
> > In tools/testing/selftests/net/tcp_fastopen_backup_key.sh line 33:
> >         if [ $val -ne 0 ]; then
> >              ^-- SC2086: Double quote to prevent globbing and word splitting.
> >
> > Rework to add double quotes around the variable 'val' that shellcheck
> > recommends.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  tools/testing/selftests/net/tcp_fastopen_backup_key.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
> > b/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
> > index 41476399e184..ba5ec3eb314e 100755
> > --- a/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
> > +++ b/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
> > @@ -30,7 +30,7 @@ do_test() {
> >       ip netns exec "${NETNS}" ./tcp_fastopen_backup_key "$1"
> >       val=$(ip netns exec "${NETNS}" nstat -az | \
> >               grep TcpExtTCPFastOpenPassiveFail | awk '{print $2}')
> > -     if [ $val -ne 0 ]; then
> > +     if [ "$val" -ne 0 ]; then
>
> Did you test this in the failing environment?

I thought I did that but the environment wasn't exactly the same. =/

>
> With a busybox shell, I get:
>  $ [ "" -ne 0 ]
> sh: bad number
>
> You might need to explicitly check for empty string here, or switch to a string comparison instead:
> if [ "$val" != 0 ]; then

I'll do that instead.

Sending out a v2 shortly.

Cheers,
Anders

>
>    -- Tim
>
> >               echo "FAIL: TcpExtTCPFastOpenPassiveFail non-zero"
> >               return 1
> >       fi
> > --
> > 2.20.1
>
