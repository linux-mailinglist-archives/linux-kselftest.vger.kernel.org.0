Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B7ECF5F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2019 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKBPIw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Nov 2019 11:08:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46470 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKBPIw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Nov 2019 11:08:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so17143770qtq.13
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Nov 2019 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mcyjyeo5WD7WfTXx5Ng2X1so4evuHV4V8GiglpDl1VQ=;
        b=XmN6x7X/6p6GWDZ4C4LAFG+DZtShPzLwGySyhtUf47HD6Gg+kjSJXVo9ieA+awfL6y
         KXpGd3TcdpJ8EQQbKdeWxzD8GY4dooWC2BudrcnBjYnyLSCgFXhXSEFA1XOZdFNa48Qr
         QErBYKpXEs8hxgxjM/6oWGziPCJEQ6a7J+FdsmbKcdU0RkxOpmbEQI+40YaXQSSIKcUm
         LKXia5WzKCmTnfMmV3mYR0I3gJFY5Utep6jCeN9sGBVkdXr/9rtpPnJWDxu/elTf0VR0
         qqyrBLtRId/vacL4VePmGS+kC6k3y+1z6DU0wf91tDnD+l/oQjPWdEypG/euW7f2+NwN
         8toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mcyjyeo5WD7WfTXx5Ng2X1so4evuHV4V8GiglpDl1VQ=;
        b=DB7iWweA0ynq2kRfs3d/2uXF3dWmsTLlLhosRet8EdTJH1jle8maXAjGOQCiV9lSm6
         w153rn3RUxZYdQF1pTS3ILrLDl1fBFRGd+SqHl8X1rlhPL6MDbjD2DvDwk3WlWwCD/x1
         3SOPVZtjM98NvULgT4VM21mK1LjDUcB9Bb8D0pSPofsWtcA2h5qa5+tTZLyjXIPU9wyY
         60Ta3hWeDzAV6k22X2+MMSvvq7O3bWhhWZhF89yFA4KQ4ql/HAlO8/qdBVCe5a6KV+wU
         zXOpqvQpTxKPFOYL+VlfVNCGGb4WMci7vFv876wTGGwj6hz0cwI4r6epu3gTjJlyAcu7
         eyfg==
X-Gm-Message-State: APjAAAVKm+7FeXNcDuEFdQA8bwWI+Mq0bxC83HifooGUvspPWzKWaG0D
        76nGExcgiGQ/tN1thEIO6MVdSjbIFU7j/fTJaOK38C9j
X-Google-Smtp-Source: APXvYqwlaOxZ+q/nRUGFIKOc0JJqqfAJQD7KYK1D1hqyIzwTOjKsvx+jZDKnZ4er2bXZRNoCmvkgrMmIKFXi/CxGFh8=
X-Received: by 2002:ac8:109:: with SMTP id e9mr5054431qtg.233.1572707331375;
 Sat, 02 Nov 2019 08:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191101233408.BC15495C0902@us180.sjc.aristanetworks.com> <0a03def6-3ea0-090f-048f-877700836df2@gmail.com>
In-Reply-To: <0a03def6-3ea0-090f-048f-877700836df2@gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Sat, 2 Nov 2019 08:08:40 -0700
Message-ID: <CA+HUmGgDrY9A7kz7268ycAOhExA3Y1h-QhBS6xwbWYxpUODDWw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftest: net: add icmp reply address test
To:     David Ahern <dsahern@gmail.com>
Cc:     David Miller <davem@davemloft.net>, shuah@kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 2, 2019 at 7:34 AM David Ahern <dsahern@gmail.com> wrote:
>
> It would be better to combine both of these into a single test script;
> the topology and setup are very similar and the scripts share a lot of
> common code.

Sure, I can do that.

> Also, you still have these using macvlan devices. The intent is to use
> network namespaces to mimic nodes in a network. As such veth pairs are a
> better option for this intent.
>

I am only using macvlans for N1 in the ipv6 test, where there are 3 nodes.
How do I use veths for that?

Thanks,
Francesco
