Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5882809A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 23:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgJAVt7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 17:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVt7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 17:49:59 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BF6C0613D0
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Oct 2020 14:49:59 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u19so146116ion.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Oct 2020 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Iy5S/CocA4xCeHEwjE56oFZuNhGNChEoPiCnQuweeI=;
        b=JF12ACJLftzwhNu9nVnsKGKuCmb4iMZtewMkS5axJYVffQIRSTwSZr3V7JiYxwCSwb
         DaUIPYVSZjV7tjbEdAyrhQn92sCld8QDD1p5WjTE2GTOGKt40oeZCxmUidqzipkWbbQb
         sb0TithxjeKXf1HPKecZcq/1PCDERmGY7XQxrSuqM1dFGXPBY2knwmTnqGfVYNld5QW6
         pXZpYvlLfdg3C8PKJq/WzVT0wNZBVEFEBv3mGrgDh3bdDYZsZdXx+Xh6dtSUZt0Frrdi
         X2VRedTWdouNk26PfNx+bjw853bfjVxPL5GXl5dzWw222dfTmJH2vCSfwPwQ1EFTavGZ
         ISBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Iy5S/CocA4xCeHEwjE56oFZuNhGNChEoPiCnQuweeI=;
        b=bErin5apDnBM9Y5Vy41PqfmSYLsSYEUJJ0wwQAByffId9OvBxY4rjZWPOdu0SciLsa
         XlKDhDVrztij/23dLExmiHOY9alyVtxl2ozHEK8xz/cZdIGIrjkd44VDmzsgQodAJWpi
         vCklJ4YhOGBK+gHHIEb2GpR81xodcVIgcb2m1aIVy7mzHSWE2Y2u6D5SGEnnmvbpwKMk
         H0rHxhK3YfkxrAds18L4wSu5+UxhFe6UPjUGhEAxrtpmC/83hXcl7Qsghn3e8t6ea5aL
         XIoZQR0xHZTn57egtAP0kdb8q/twwiDEai3m8iWKilN4C4ULC1BdmvZ1lY4vqnni0Agm
         ZHqg==
X-Gm-Message-State: AOAM5314YwtMxf6lxOcLyPLDavovsRyxDTetXzg4crNKGLif+vDGUUGa
        KOqXhNcvsr0ZXxSo60/8aFOTlzjxuUMXu+8BdEUZcw==
X-Google-Smtp-Source: ABdhPJzs96cfey8q3xfC68y/H4jPYcqEEDpnSYeDMjEeFUGu22lKOJNhMhPS834Wj0unntcNunS6X7sjvEWpyvdJwYs=
X-Received: by 2002:a6b:d60b:: with SMTP id w11mr4673204ioa.198.1601588998029;
 Thu, 01 Oct 2020 14:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com> <CAGS_qxpt1NLhh=XEKLCNEayTmB4ZhjOY32XjmL1YRPDnYVvYMw@mail.gmail.com>
 <CAFd5g44dLSRUVMA6ggYFACNcYtuh5-z7JyMzpBpjXG3UvBh-zg@mail.gmail.com>
In-Reply-To: <CAFd5g44dLSRUVMA6ggYFACNcYtuh5-z7JyMzpBpjXG3UvBh-zg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 1 Oct 2020 14:49:46 -0700
Message-ID: <CAGS_qxqSgcJaWAR6=382e0YYHAEtZg5UjgPGSf_5NzbO8W0T+g@mail.gmail.com>
Subject: Re: [RFC v1 00/12] kunit: introduce class mocking support.
To:     Brendan Higgins <brendanhiggins@google.com>
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

On Mon, Sep 28, 2020 at 4:24 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Sep 22, 2020 at 5:24 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Fri, Sep 18, 2020 at 11:31 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > # Background
> > > KUnit currently lacks any first-class support for mocking.
> > > For an overview and discussion on the pros and cons, see
> > > https://martinfowler.com/articles/mocksArentStubs.html
> > >
> > > This patch set introduces the basic machinery needed for mocking:
> > > setting and validating expectations, setting default actions, etc.
> > >
> > > Using that basic infrastructure, we add macros for "class mocking", as
> > > it's probably the easiest type of mocking to start with.
> > >
> > > ## Class mocking
> > >
> > > By "class mocking", we're referring mocking out function pointers stored
> > > in structs like:
> > >   struct sender {
> > >         int (*send)(struct sender *sender, int data);
> > >   };
> >
> > Discussed this offline a bit with Brendan and David.
> > The requirement that the first argument is a `sender *` means this
> > doesn't work for a few common cases.
> >
> > E.g. ops structs don't usually have funcs that take `XXX_ops *`
> > `pci_ops` all take a `struct pci_bus *`, which at least contains a
> > `struct pci_ops*`.
> >
> > Why does this matter?
> > We need to stash a  `struct mock` somewhere to store expectations.
> > For this version of class mocking (in patch 10), we've assumed we could have
> >
> > struct MOCK(sender) {
> >          struct mock ctrl;
> >          struct sender trgt; //&trgt assumed to be the first param
> > }
> >
> > Then we can always use `container_of(sender)` to get the MOCK(sender)
> > which holds `ctrl`.
> > But if the first parameter isn't a `struct sender*`, this trick
> > obviously doesn't work.
> >
> > So to support something like pci_ops, we'd need another approach to
> > stash `ctrl`.
> >
> > After thinking a bit more, we could perhaps decouple the first param
> > from the mocked struct.
> > Using pci_ops as the example:
> >
> > struct MOCK(pci_ops) {
> >          struct mock ctrl;
> >          struct pci_bus *self; // this is the first param. Using
> > python terminology here.
> >          struct pci_ops trgt; // continue to store this, as this holds
> > the function pointers
> > }
> >
> > // Name of this func is currently based on the class we're mocking
> > static inline struct mock *from_pci_ops_to_mock(
> >   const struct pci_bus *self)
> > {
> >           return mock_get_ctrl(container_of(self, struct MOCK(pci_ops), self));
> > }
> >
> > // then in tests, we'd need something like
> > struct pci_bus bus;
> > bus.ops = mock_get_trgt(mock_ops);
> > mock_ops.self = &bus;
> >
> > Do others have thoughts/opinions?
>
> In the above example, wouldn't we actually want to mock struct
> pci_bus, not struct pci_ops?
>
> I think pci_bus is what actually gets implemented. Consider the
> Rockchip PCIe host controller:
>
> Rockchip provides it's own pci_ops struct:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/pcie-rockchip-host.c#L256
>
> If you look at one of the implemented methods, say
> rockchip_pcie_rd_conf(), you will see:
>
> ...
> struct rockchip_pcie *rockchip = bus->sysdata;
> ...
> (This function signature is:
>
> int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int
> size, u32 *val);
>
> ).
>
> Thus, conceptually struct pci_bus is what is being manipulated; it
> best fits the candidate for the *self pointer.
>
> In fact - if I am not mistaken - I think if you were to mock pci_bus
> and just pretend that the methods were on pci_bus, not pci_ops, I
> think it might just work.

It works with this code as-is, yes.

But messing around with it, it seems like it might be helpful for the
mock init funcs access to `struct kunit *test` in case they want to
allocate.

E.g. in cases where the ops struct points to a shared instance.
We'd want to allocate a new ops struct so we don't accidentally affect
more objects than expected by altering global state.

It's a simple enough change, i.e.

diff --git a/include/kunit/mock.h b/include/kunit/mock.h
index 955c4267d726..9006f0e492dc 100644
--- a/include/kunit/mock.h
+++ b/include/kunit/mock.h
@@ -613,7 +613,7 @@ static inline bool is_naggy_mock(struct mock *mock)
                                                                               \
                        mock_init_ctrl(test, mock_get_ctrl(mock_obj));         \
                                                                               \
-                       if (init_func(mock_obj))                               \
+                       if (init_func(test, mock_obj))                         \
                                return NULL;                                   \
                                                                               \
                        return mock_obj;                                       \
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index cd538cdb2a96..38c87f163d2f 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -66,7 +66,7 @@ DEFINE_STRUCT_CLASS_MOCK(METHOD(foo), CLASS(example),
  * parent. In this example, all we have to do is populate the member functions
  * of the parent class with the mock versions we defined.
  */
-static int example_init(struct MOCK(example) *mock_example)
+static int example_init(struct kunit *test, struct MOCK(example) *mock_example)
 {
        /* This is how you get a pointer to the parent class of a mock. */
        struct example *example = mock_get_trgt(mock_example);

>
> The bigger problem is that it seems pci_bus does not want the user to
> allocate it: in the case of rockchip_pcie, it is allocated by
> devm_pci_alloc_host_bridge(). Thus, embedding pci_bus inside of a
> MOCK(pci_bus) would probably not work, so you would need to have
> different tooling around that and would then need to provide a custom
> definition of from_pci_bus_to_mock() (generated by
> DECLARE_STRUCT_CLASS_MOCK_CONVERTER()).

Yeah, I'm still not sure about this.

One approach would be to only support objects we can allocate and thus
embed inside a wrapper MOCK(class) struct.
Users would have to write a custom wrapper struct and
from_<class>_to_mock() funcs for everything else.

E.g. they'd write

struct MOCK(pci_bus) {
  struct mock ctrl;
  struct pci_bus *bus; // normally, the macro would generate without *
}

static inline struct mock *from_pci_ops_to_mock(
    const struct pci_bus *self) {
  // let user provide magic logic to do this lookup
 struct MOCK(pci_bus) *mock = somehow_get_wrapper(pci_bus);
 return mock_get_ctrl(mock);
}

With the proposed change above to pass a `struct kunit *` to the init,
we open the possibility of using a kunit_resource to store this
mapping.
Perhaps the conversion func could also be changed to take a `struct
kunit *` as well?

static int mock_pci_bus_init(struct kunit *test, struct MOCK(pci_bus) *mocked) {
  // somehow establish mapping
 kunit_add_named_resource(test, ....);
}

Given resources are looked up via a linear scan, perhaps we do
something like create a single instance for each mocked type.
E.g. we have a `map_pci_bus_to_mock` hashtable that either gets
allocated or updated with each call?

>
> > After grepping around for examples, I'm struck by how the number of
> > outliers there are.
> > E.g. most take a `struct thing *` as the first param, but cfspi_ifc in
> > caif_spi.h opts to take that as the last parameter.
>
> That's not a problem, just use the
> DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX() variant to create your mock
> (as opposed to DECLARE_STRUCT_CLASS_MOCK()).

Here's the function pointers
  void (*ss_cb) (bool assert, struct cfspi_ifc *ifc);
  void (*xfer_done_cb) (struct cfspi_ifc *ifc);

So sadly that won't work (unless you only wanted to mock one of the funcs).
But as we agree that we don't want to try and support everything, this is fine.

>
> For example let's say you have the following struct that you want to mock:
>
> struct example {
>     ...
>     int (*foo)(int bar, char baz, struct example *self);
> };
>
> You could mock the function with:
>
> DECLARE_STRUCT_CLASS_MOCK_HANDLE_INDEX(
>     METHOD(foo), CLASS(example),
>     2, /* The "handle" is in position 2. */
>     RETURNS(int),
>     PARAMS(int, char, struct example *));
>
> > And others take a different mix of structs for each function.
> >
> > But it feels like a decoupled self / struct-holding-func-pointers
> > approach should be generic enough, as far as I can tell.
> > The more exotic types will probably have to remain unsupported.
>
> I think the code is pretty much here to handle any situation in which
> one of the parameters input to the function can be used to look up a
> mock object; we just need to expose the from_<class>_to_mock()
> function to the user to override. The problem I see with what we have
> now is the assumption that the user gets to create the object that
> they want to mock. Your example has illustrated that that is not a
> safe assumption.

Agree.
The code itself is more or less able to handle most of these use cases.
Concern was more about how frequent + painful minor deviations from
the current pattern would be.
As noted above, I think allowing the mock init funcs to safely
allocate a new ops struct if they want might be enough.

For more exotic cases, users can write custom from_<class>_to_mock()
funcs to handle a lot of cases.
As long as the first argument to the mocked functions matches the
first argument of _to_mock(), then it should all work out.

>
> But yes, sufficiently exoctic cases will have to be unsupported.
>
> BTW, sorry for not sharing the above in our offline discussion; since
> we were talking without concrete examples in front of us, the problem
> sounded worse than it looks here.
>
> [...]
