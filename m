Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B81FD4AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgFQSk3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 14:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFQSkY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 14:40:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAEBC0613EF
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 11:40:24 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so1487110pjb.5
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jun 2020 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KcSum0XnLgDWG/9J1zd7huPRZUcbTdd3T0stJfNhXtU=;
        b=hHeKJA5bpWojfm1pX2unVw+EfqUuRl8oPBdUNPLoCxjZ64sU0oStIKYfknHILmDFaZ
         H9ZHJAe3xkt0qMgGgjNa6EjvRt/0qyjX/4NrDrZCZMQNniC1zsg9rGq+JkViIVv/0vWR
         +7lVX4VJq+6OYKuN/6lWKksWFEEFKKkIWjELs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KcSum0XnLgDWG/9J1zd7huPRZUcbTdd3T0stJfNhXtU=;
        b=JI5dE7pTWIor4e5nH312LnE4y1P7y24GUvpSt0SxjGoRH+HqdjJitjf7mv43WxYWxO
         f3g6srcTdPt6+caGyfLzEKLlsVrmK+QYoN7qIoH9TEO047ctlJK1Qy3B1y55rGgyOZNO
         bbSq68Fodocv5/BKmaeJbhYAmqzCOO4sL9eJcx77cqbbhSjBNtwvhW+GMHFIxqXgRvm9
         KH+g7vCzXvCwGvna6sRL0Y0Y5ddW4ZJIQFgTi2Iz3JXSWK39NqfAaFD3Dt6Bt/t3I+uj
         TgQUV69+vJ4yMX/7jYBaOUSqB34en/1RNCZlLi6X3FEnObhnpeiQGYynnd4PfHLbifmX
         iM8A==
X-Gm-Message-State: AOAM5339nVXQABjFlnVd7mkPe7yN14oq45yCTqMx4QzTfn8VCZRhlD4J
        nXctwxj1SfID59w2nDHwjFOCkw==
X-Google-Smtp-Source: ABdhPJzMCEeKbMD2vkbh+chVGcN7dvBNIk/GO49GvRnea+7Iwh7JIl8l4xjbafw6OC9ChWgKjmpkjA==
X-Received: by 2002:a17:90a:218c:: with SMTP id q12mr383955pjc.116.1592419223126;
        Wed, 17 Jun 2020 11:40:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u128sm506788pfu.148.2020.06.17.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:40:21 -0700 (PDT)
Date:   Wed, 17 Jun 2020 11:40:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 02/11] fs: Move __scm_install_fd() to
 __fd_install_received()
Message-ID: <202006171139.98B1735@keescook>
References: <20200616032524.460144-1-keescook@chromium.org>
 <20200616032524.460144-3-keescook@chromium.org>
 <b58ef9a368214b69a86c7a78b67f84d5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58ef9a368214b69a86c7a78b67f84d5@AcuMS.aculab.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 17, 2020 at 03:25:41PM +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 16 June 2020 04:25
>  
> > In preparation for users of the "install a received file" logic outside
> > of net/ (pidfd and seccomp), relocate and rename __scm_install_fd() from
> > net/core/scm.c to __fd_install_received() in fs/file.c, and provide a
> > wrapper named fd_install_received_user(), as future patches will change
> > the interface to __fd_install_received().
> 
> Any reason for the leading __ ??

Mainly because of the code pattern of only using the inline helpers to
call it.

-- 
Kees Cook
