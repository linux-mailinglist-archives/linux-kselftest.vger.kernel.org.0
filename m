Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 741BCCC52A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2019 23:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfJDVrp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Oct 2019 17:47:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42923 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDVrp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Oct 2019 17:47:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so7900992lje.9
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2019 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSvi6bN3MgmA9q6zMgIL0cUcdQWLY9tbHblghBTgstI=;
        b=hBuewRInP5i+6gtlRLW9UtlDY0YPe0z67E0xbXSSSKYA7biQf+uXTlrPp7zLuAUPeq
         5uQ2rwixtXebf99m1RfUdMDyjGKPh3VgF3DuF8NvshRtQGRa2wNkvwDCWMNQ0VKjXHWB
         ZmI6XqYkyQwmdmiffnmLI1+ZMJ0oT9STysqR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSvi6bN3MgmA9q6zMgIL0cUcdQWLY9tbHblghBTgstI=;
        b=CMG4phpnaaX/beb/UfrNzhzOGk5AHiAADa39IJTyMCQljOa2SdzOL/+/Bo31GxmU3z
         nFXU4sCfqbPKfrMNMawur9r02GrxHIDsJoNa6l/B4WQhccMgibwX6k95n1h7UCwElaEr
         uGcyVGs0M0p8erQMtaVRRc34qJ4XUkiZckzyJNnryyxHbAOSBl2mh7uAVOFlDYi/1NCF
         qE6eUFm2CWu0y8S3inXy9yqq38Hp+y9ulbsj9w6zNc/pvqTBUKSDMYf6fp1xrSPPvyc+
         JAqyF1ADva3PL6Fg7JffTw6R+NFzCHVuFeXTX462D5IejwxoS+kx0cAe2vq0Hwjhyt06
         grTw==
X-Gm-Message-State: APjAAAVOO+ouHtcxd/QTGXpFwDiYS9iod8gqHjy97+8u7NdPgdhT18mo
        mBOu+n7ZJ+I9S7BHEzlqdx77J4GPzs4=
X-Google-Smtp-Source: APXvYqymaGVGgonhCdJ3IA3Wpz4FFefZCbB7Qka4PQUMk9QYdEDL4pZeCWnCLDWI3rlGc8jz6CWa1A==
X-Received: by 2002:a2e:95ca:: with SMTP id y10mr11029224ljh.141.1570225663518;
        Fri, 04 Oct 2019 14:47:43 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id k23sm1537563ljc.13.2019.10.04.14.47.43
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 14:47:43 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 72so5452427lfh.6
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2019 14:47:43 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr10113290lfc.106.1570225353484;
 Fri, 04 Oct 2019 14:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com> <20191004213812.GA24644@mit.edu>
In-Reply-To: <20191004213812.GA24644@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Oct 2019 14:42:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
Message-ID: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        kieran.bingham@ideasonboard.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, robh@kernel.org,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>, Tim.Bird@sony.com,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, jdike@addtoit.com,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> This question is primarily directed at Shuah and Linus....
>
> What's the current status of the kunit series now that Brendan has
> moved it out of the top-level kunit directory as Linus has requested?

We seemed to decide to just wait for 5.5, but there is nothing that
looks to block that. And I encouraged Shuah to find more kunit cases
for when it _does_ get merged.

So if the kunit branch is stable, and people want to start using it
for their unit tests, then I think that would be a good idea, and then
during the 5.5 merge window we'll not just get the infrastructure,
we'll get a few more users too and not just examples.

             Linus
