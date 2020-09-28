Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4636D27B809
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 01:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgI1XYh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 19:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgI1XYh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 19:24:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31277C0613D3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 16:24:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so2670030pff.6
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8c07NCI0HNyfXA8pNgzDuXTfAuvdY/rU2PMr/Kt1gE=;
        b=Kd6WT9dbwHkkmu8kpx/n9Lm5oozOFJtfnMPVThHwHXXdkXXa+d6q82yImX08oVRfb0
         h4Ihz7RvaRAuevB7IgvvAJubZaJ7Sfnj6jleqaFR2+VKhr9OOdOPNcBb6tllCi57ounz
         gu9ECoqp0Dgxz52ntjUnsoQwI6lK2cvmsowWnfTI1ZcqLnmrRh/bgxLV1XJWvaN24jFD
         EqQlD5o3cdL3m8hfyo8pLU1BtZyDhdZwHq1NOc9V4hh2MRt7zQHf++k9tgB4fEKhOApI
         Z6/m1EKa3uizyyVFkT4ibgf45o5d/aHx5svhDl3f/p9xDJNypXftBhltZ/ywIcGvIzid
         8ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8c07NCI0HNyfXA8pNgzDuXTfAuvdY/rU2PMr/Kt1gE=;
        b=KrhvonNj7iRceRGDJmtt+aMLNUUvudWX3T0QlCSeZMuP6HmAxkyKqfl3uydM/UD6j+
         3U0DjFaivLJ1zoB6pI7knjhFmJwD+cpt2/mTjL3rSxS3zooai8H195W4o/m+2HYLNH6d
         1tYgK3UJQ08a/snyTke0/RfjOphM7CCdbDMJCwqyn8DEK6cjv/wW1IhxNkg5CZXmjKu+
         sXHyUfc74wzCiDYt9VHtsfwCzKmE5k7XHJ8gILhDGnZx+mvxVoSDaq+6lHK2/eoLG54Q
         +aFgy0DAzsUgzSq1TdzSHmImgBEuRb8+8+qiQXh/92xMPraS4rYH0xWB5wbiJu/r8ZUu
         Fa0g==
X-Gm-Message-State: AOAM532EzLDoS7U2JU7vbDfWqw8Tgl1HE7KwpjZPcTDdPzUcL8OuHa8k
        OvQhsqGsNE6gWw3juuwZrbSR2i7axmWeNTyTxFIClA==
X-Google-Smtp-Source: ABdhPJzlUY0jjFKVbxniJdGEY8S7rc5WyJxI+1qW0Yunn4msssQLOsFHaOmHFb07b0vRqLL6rkQB5KEb0m4bquqyU8U=
X-Received: by 2002:a63:fd03:: with SMTP id d3mr999729pgh.201.1601335476300;
 Mon, 28 Sep 2020 16:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com> <CAGS_qxpt1NLhh=XEKLCNEayTmB4ZhjOY32XjmL1YRPDnYVvYMw@mail.gmail.com>
In-Reply-To: <CAGS_qxpt1NLhh=XEKLCNEayTmB4ZhjOY32XjmL1YRPDnYVvYMw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Sep 2020 16:24:25 -0700
Message-ID: <CAFd5g44dLSRUVMA6ggYFACNcYtuh5-z7JyMzpBpjXG3UvBh-zg@mail.gmail.com>
Subject: Re: [RFC v1 00/12] kunit: introduce class mocking support.
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 22, 2020 at 5:24 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Sep 18, 2020 at 11:31 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > # Background
> > KUnit currently lacks any first-class support for mocking.
> > For an overview and discussion on the pros and cons, see
> > https://martinfowler.com/articles/mocksArentStubs.html
> >
> > This patch set introduces the basic machinery needed for mocking:
> > setting and validating expectations, setting default actions, etc.
> >
> > Using that basic infrastructure, we add macros for "class mocking", as
> > it's probably the easiest type of mocking to start with.
> >
> > ## Class mocking
> >
> > By "class mocking", we're referring mocking out function pointers stored
> > in structs like:
> >   struct sender {
> >         int (*send)(struct sender *sender, int data);
> >   };
>
> Discussed this offline a bit with Brendan and David.
> The requirement that the first argument is a `sender *` means this
> doesn't work for a few common cases.
>
> E.g. ops structs don't usually have funcs that take `XXX_ops *`
> `pci_ops` all take a `struct pci_bus *`, which at least contains a
> `struct pci_ops*`.
>
> Why does this matter?
> We need to stash a  `struct mock` somewhere to store expectations.
> For this version of class mocking (in patch 10), we've assumed we could have
>
> struct MOCK(sender) {
>          struct mock ctrl;
>          struct sender trgt; //&trgt assumed to be the first param
> }
>
> Then we can always use `container_of(sender)` to get the MOCK(sender)
> which holds `ctrl`.
> But if the first parameter isn't a `struct sender*`, this trick
> obviously doesn't work.
>
> So to support something like pci_ops, we'd need another approach to
> stash `ctrl`.
>
> After thinking a bit more, we could perhaps decouple the first param
> from the mocked struct.
> Using pci_ops as the example:
>
> struct MOCK(pci_ops) {
>          struct mock ctrl;
>          struct pci_bus *self; // this is the first param. Using
> python terminology here.
>          struct pci_ops trgt; // continue to store this, as this holds
> the function pointers
> }
>
> // Name of this func is currently based on the class we're mocking
> static inline struct mock *from_pci_ops_to_mock(
>   const struct pci_bus *self)
> {
>           return mock_get_ctrl(container_of(self, struct MOCK(pci_ops), self));
> }
>
> // then in tests, we'd need something like
> struct pci_bus bus;
> bus.ops = mock_get_trgt(mock_ops);
> mock_ops.self = &bus;
>
> Do others have thoughts/opinions?

In the above example, wouldn't we actually want to mock struct
pci_bus, not struct pci_ops?

I think pci_bus is what actually gets implemented. Consider the
Rockchip PCIe host controller:

Rockchip provides it's own pci_ops struct:

https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/pcie-rockchip-host.c#L256

If you look at one of the implemented methods, say
rockchip_pcie_rd_conf(), you will see:

...
struct rockchip_pcie *rockchip = bus->sysdata;
...
(This function signature is:

int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int
size, u32 *val);

).

Thus, conceptually struct pci_bus is what is being manipulated; it
best fits the candidate for the *self pointer.

In fact - if I am not mistaken - I think if you were to mock pci_bus
and just pretend that the methods were on pci_bus, not pci_ops, I
think it might just work.

The bigger problem is that it seems pci_bus does not want the user to
allocate it: in the case of rockchip_pcie, it is allocated by
devm_pci_alloc_host_bridge(). Thus, embedding pci_bus inside of a
MOCK(pci_bus) would probably not work, so you would need to have
different tooling around that and would then need to provide a custom
definition of from_pci_bus_to_mock() (generated by
DECLARE_STRUCT_CLASS_MOCK_CONVERTER()).

> After grepping around for examples, I'm struck by how the number of
> outliers there are.
> E.g. most take a `struct thing *` as the first param, but cfspi_ifc in
> caif_spi.h opts to take that as the last parameter.

That's not a problem, just use the
DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX() variant to create your mock
(as opposed to DECLARE_STRUCT_CLASS_MOCK()).

For example let's say you have the following struct that you want to mock:

struct example {
    ...
    int (*foo)(int bar, char baz, struct example *self);
};

You could mock the function with:

DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX(
    METHOD(foo), CLASS(example),
    2, /* The "handle" is in position 2. */
    RETURNS(int),
    PARAMS(int, char, struct example *));

> And others take a different mix of structs for each function.
>
> But it feels like a decoupled self / struct-holding-func-pointers
> approach should be generic enough, as far as I can tell.
> The more exotic types will probably have to remain unsupported.

I think the code is pretty much here to handle any situation in which
one of the parameters input to the function can be used to look up a
mock object; we just need to expose the from_<class>_to_mock()
function to the user to override. The problem I see with what we have
now is the assumption that the user gets to create the object that
they want to mock. Your example has illustrated that that is not a
safe assumption.

But yes, sufficiently exoctic cases will have to be unsupported.

BTW, sorry for not sharing the above in our offline discussion; since
we were talking without concrete examples in front of us, the problem
sounded worse than it looks here.

[...]
