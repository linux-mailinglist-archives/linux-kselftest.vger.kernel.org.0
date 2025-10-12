Return-Path: <linux-kselftest+bounces-42980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA0CBD034A
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 16:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825881894E44
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BE283CA7;
	Sun, 12 Oct 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI/1u+4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95B28369A
	for <linux-kselftest@vger.kernel.org>; Sun, 12 Oct 2025 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278787; cv=none; b=WzViDJDLclA+KHKzACwi9ltfUMA19RFTCcZPDii8j5nAU8IdnIRJS9jkVlag0/oQvhOa6teYZI9iK938kOEiAa/ma0Wk9kUvhb8/FnQMkjWKL2/34Rpar2i/xYr4khzc+igckV2Jaz3YM/lFf2Ta7nLv7XQhs4Bs7qwAo5P7RGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278787; c=relaxed/simple;
	bh=S0RjN53FhosHFqH1eQVEkBO1CL2bCSvSztX6fZqueyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgeL5U9VMnHUteR3LU2GyfgRUnayHjcG1EDo+LzFKhfnTwqxLJPIwLe2k19KEMjF1+ty9GXsWws4iXeZ77TDJTB8yFKnR6ymASWaxob8Xtozin+yIZ9umTzPvFmizlNfaUkFlyB+YeVHRdrHaoBmKwvyFIfpxPpzy10wWGuTv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI/1u+4c; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-855d525cd00so602435885a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Oct 2025 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760278783; x=1760883583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/781Ye50yRSfgbM0sVXYJ3EacOElPA86Mq2WbSzU9U=;
        b=PI/1u+4c7HEONsZ5wqMM8v1aHnrW7P10BCfBFYxIWQ2HTH6z5WDB0TC+mhHr6pQrRw
         xYwjYwQ8pkDNgvg2GQqKRuSs7CcmiWml36RqtQdwuWej3EsGi8JolLi64nLN1FRXlRuG
         aAIbKpzIN5S0EqYv47oe1M5NRzXWc5JeIHeRxwDRctmo0vQUjV+zP3VvKuDRdzD2f4aM
         jp1KIaKjF9eYBOLCR4l6/gsdqFLpcvxVSkFarizWtiJ1lY+sCkK2PVpipqkyPCwCYf1l
         GoPinO9ujj6yjabGBI5/CenkyoXngcOKwSQnDlO0yPNSbIyaEqTUJnTbEiF3/tPbqzOD
         vwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760278783; x=1760883583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/781Ye50yRSfgbM0sVXYJ3EacOElPA86Mq2WbSzU9U=;
        b=WZaPLKrCAWq/C6mFv3Fg2V3BmyItfRPptFqxWqNePcKtY+DP+7zVYO1BCpTb0EoRCB
         Ktb9kGev0ne3oodMgmsQRIgNLtwY3DVfN4J3eOPLTnvMgzJir34m2u3D8Emx01ISG8xV
         BGONMAXcs02pwEQKOjKy3G/47FAfE6DsDuhoTqP6RosByG+IW+e/RcPPl+qcpVd4NjfE
         6DqJyK5k8HyleXiEY59ZHllOxFSLLXMO4R6x/WygtSzjDX8CK7lbeyLgWYJRS0Z0yP+n
         yFhUTEaXvWI6klOrViDU8XxyekHPB+OD4/JkGVUHcnbCiJhapDpO2ThnQ3/lcfZz3vRT
         v/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWGIar7eCyvcnDhqi5caDHxYO5osEqXnnQxvVTZIFzOoXWtW1O8Jr29EWpUApPDkt0oTqgMiBido/wz/zRMb/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyghKdRqYrXV7z1N8RtnnfJ0EEhzKQVKsZO33FUaK8LJWRktJHC
	liRGHrTdh7AC4ukY0N8zvwRWfm8S7gjwA8jmPqyoZ+XTlNOI3uBADjRL
X-Gm-Gg: ASbGncufou3N+qDgAgrCUIqq9qS30mm68LgKvHbUci96/ChA9gZUMwB1Oyn81zEEUFI
	4DII5F60TRdjTH0SlzbWoZalZQne4wQK4069HanZTe22HFH3/RHLG3gBIGzHMDCIZqv9bfHXKJJ
	8apMYweg9nM9a5Z0aTU5W/Sxl+mQGlgRy9NiRBzC+qAu5HHvQwYqY2lbFnzJPF6iVTgdK4NgXhD
	EOj07FA1Eyh0yiBOZ8zf31l2fpNMfXRBKii/2/9Vy/R35Bz9Wwmew+03GnH2Hc9KhqZsoJRbFAP
	Tme6U2McxAJzvVPG4zE3HNiV/oQTGzUYMlifGvhewI6YXl7KhUzm1nymzj8rcYMayXhJ4ejoiEJ
	zsDMbA2Fo1aup7mpeu0j26qFLk5kZetwKm/tFKtdgrArAIiZ1Rwrm
X-Google-Smtp-Source: AGHT+IFAXQttV0gVKtNIYGQh3pzgscmaOrpvGng16uvi0C8x1olqSjkESlIelbf97EwdfKqOZ27z7A==
X-Received: by 2002:a05:622a:14c6:b0:4da:21ee:247b with SMTP id d75a77b69052e-4e6ead768e6mr242310381cf.47.1760278783042;
        Sun, 12 Oct 2025 07:19:43 -0700 (PDT)
Received: from gmail.com ([2600:4041:4491:2000:f887:3bb2:9bc6:cbb0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e721452e03sm14285111cf.4.2025.10.12.07.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:19:41 -0700 (PDT)
Date: Sun, 12 Oct 2025 23:19:39 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
	hca@linux.ibm.com, corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/5] tracing: fprobe: support comma-separated symbols
 and :entry/:exit
Message-ID: <aOu4-3QNhJi8kVXb@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
 <20251004235001.133111-4-seokwoo.chung130@gmail.com>
 <20251008190937.c7c992e41b4397fecbc8176e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008190937.c7c992e41b4397fecbc8176e@kernel.org>

Hi. Thanks for the quick review and comments. Here are my responses to
the remaining points.

On Wed, Oct 08, 2025 at 07:09:37PM +0900, Masami Hiramatsu wrote:
> On Sun,  5 Oct 2025 08:46:57 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> Please describe what this patch adds, for what reason.
> 

This is my mistake; I forgot to do so. I will make sure to include it
next time.

> > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> > ---
> >  kernel/trace/trace_fprobe.c | 247 ++++++++++++++++++++++++++++--------
> >  1 file changed, 192 insertions(+), 55 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index b36ade43d4b3..ec5b6e1c1a1b 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -191,6 +191,9 @@ struct trace_fprobe {
> >  	bool			tprobe;
> >  	struct tracepoint_user	*tuser;
> >  	struct trace_probe	tp;
> > +	char			*filter;
> > +	char			*nofilter;
> > +	bool			list_mode;
> >  };
> >  
> >  static bool is_trace_fprobe(struct dyn_event *ev)
> > @@ -203,14 +206,10 @@ static struct trace_fprobe *to_trace_fprobe(struct dyn_event *ev)
> >  	return container_of(ev, struct trace_fprobe, devent);
> >  }
> >  
> > -/**
> > - * for_each_trace_fprobe - iterate over the trace_fprobe list
> > - * @pos:	the struct trace_fprobe * for each entry
> > - * @dpos:	the struct dyn_event * to use as a loop cursor
> > - */
> > -#define for_each_trace_fprobe(pos, dpos)	\
> > -	for_each_dyn_event(dpos)		\
> > -		if (is_trace_fprobe(dpos) && (pos = to_trace_fprobe(dpos)))
> 
> Why remove this? This is for finding all fprobes.
> 

I will revert this and keep for_each_trace_fprobe as is. 

> > +static struct trace_fprobe *trace_fprobe_from_dyn(struct dyn_event *ev)
> > +{
> > +	return is_trace_fprobe(ev) ? to_trace_fprobe(ev) : NULL;
> > +}
> >  
> >  static bool trace_fprobe_is_return(struct trace_fprobe *tf)
> >  {
> > @@ -227,6 +226,109 @@ static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
> >  	return tf->symbol ? tf->symbol : "unknown";
> >  }
> >  
> > +static bool has_wildcard(const char *s)
> > +{
> > +	return s && (strchr(s, '*') || strchr(s, '?'));
> > +}
> > +
> > +static int parse_fprobe_spec(const char *in, bool is_tracepoint,
> > +		char **base, bool *is_return, bool *list_mode,
> > +		char **filter, char **nofilter)
> > +{
> > +	const char *p;
> > +	char *work = NULL;
> > +	char *b = NULL, *f = NULL, *nf = NULL;
> 
> See below (out: label)
> 

I will switch those temporaries to __free(kfree) and drop the goto that
existed only to kfree. This addresses the cleanup pattern comment.

> > +	bool legacy_ret = false;
> > +	bool list = false;
> > +	int ret = 0;
> 
> nit: sort local variable by line length. (longer to shorter)
> 

Ok. I will sort locals longest -> shortest and fix a few initializations
(char *filter = NULL, char *nofilter = Null;).

> > +
> > +	if (!in || !base || !is_return || !list_mode || !filter || !nofilter)
> > +		return -EINVAL;
> > +
> > +	*base = NULL; *filter = NULL; *nofilter = NULL;
> > +	*is_return = false; *list_mode = false;
> > +
> > +	if (is_tracepoint) {
> > +		if (strchr(in, ',') || strchr(in, ':'))
> > +			return -EINVAL;
> > +		if (strstr(in, "%return"))
> > +			return -EINVAL;
> 
> It seems below loop checks all above cases.
> 

I will remove the redundant pre-checks and rely on the validation loop,
with precise rules. 

> > +		for (p = in; *p; p++)
> > +			if (!isalnum(*p) && *p != '_')
> > +				return -EINVAL;
> 
> This only allows that the @in must be a symbol name.
> 

Just to clarify: should tracepoint arguments support the subsystem:event
format (e.g., "sched:sched_switch"), or should they remain restricted to
simple symbol names only? The current validation enforces
symbol-name-only, but I wanted to confirm this is the intended behavior
before next version.

> > +		b = kstrdup(in, GFP_KERNEL);
> > +		if (!b)
> > +			return -ENOMEM;
> > +		*base = b;
> > +		return 0;
> > +	}
> > +
> > +	work = kstrdup(in, GFP_KERNEL);
> > +	if (!work)
> > +		return -ENOMEM;
> > +
> > +	p = strstr(work, "%return");
> 
> Note that strstr does not care it ends with given string.
> 

Good catch. I will replace it with explicit end-of-string checks so we
accept only a single terminal suffix: %return, :entry, or :exit.
Partial/embedded matches will be rejected.

> > +	if (p) {
> > +		if (!strcmp(p, ":exit")) {
> > +			*is_return = true;
> > +			*p = '\0';
> > +		} else if (!strcmp(p, ":entry")) {
> > +			*p = '\0';
> > +		} else {
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	list = !!strchr(work, ',') || has_wildcard(work);
> 
> Wildcard is OK for legacy.
> 

I will keep the wildcard acceptance for the legacy string, and treat
presence of "," or wildcard as "list mode" that builds filter/nofilter
for register_fprobe(); otherwise it remains single-symbol legacy.

> > +	if (legacy_ret)
> > +		*is_return = true;
> > +
> > +	b = kstrdup(work, GFP_KERNEL);
> > +	if (!b) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	if (list) {
> > +		char *tmp = b, *tok;
> > +		size_t fsz = strlen(b) + 1, nfsz = strlen(b) + 1;
> 
> size_t fsz, nfsz;
> 
> fsz = nfsz = strlen(b) + 1;
> 

I will adopt the above style.

> > +
> > +		f = kzalloc(fsz, GFP_KERNEL);
> > +		nf = kzalloc(nfsz, GFP_KERNEL);
> > +		if (!f || !nf) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		while ((tok = strsep(&tmp, ",")) != NULL) {
> > +			char *dst;
> > +			bool neg = (*tok == '!');
> > +
> > +			if (*tok == '\0')
> > +				continue;
> > +			if (neg)
> > +				tok++;
> > +			dst = neg ? nf : f;
> > +			if (dst[0] != '\0')
> > +				strcat(dst, ",");
> > +			strcat(dst, tok);
> > +		}
> > +		*list_mode = true;
> > +	}
> > +
> > +	*base = b; b = NULL;
> > +	*filter = f; f = NULL;
> > +	*nofilter = nf; nf = NULL;
> > +
> > +out:
> > +	kfree(work);
> > +	kfree(b);
> > +	kfree(f);
> > +	kfree(nf);
> 
> Instead of using goto only for kfree(), use __free(kfree)
> to clean those up automatically.
> 

Ok. As mentioned above, I will convert all such temporaries to
__free(kfree) and remove the goto cleanup.

> > +	return ret;
> > +}
> > +
> >  static bool trace_fprobe_is_busy(struct dyn_event *ev)
> >  {
> >  	struct trace_fprobe *tf = to_trace_fprobe(ev);
> > @@ -556,13 +658,17 @@ static void free_trace_fprobe(struct trace_fprobe *tf)
> >  		trace_probe_cleanup(&tf->tp);
> >  		if (tf->tuser)
> >  			tracepoint_user_put(tf->tuser);
> > +		kfree(tf->filter);
> > +		kfree(tf->nofilter);
> >  		kfree(tf->symbol);
> >  		kfree(tf);
> >  	}
> >  }
> >  
> >  /* Since alloc_trace_fprobe() can return error, check the pointer is ERR too. */
> > -DEFINE_FREE(free_trace_fprobe, struct trace_fprobe *, if (!IS_ERR_OR_NULL(_T)) free_trace_fprobe(_T))
> > +DEFINE_FREE(free_trace_fprobe, struct trace_fprobe *,
> > +	if (!IS_ERR_OR_NULL(_T))
> > +		free_trace_fprobe(_T))
> 
> OK, it looks good to clean up. But please do it separated patch.
> Do not touch if it is not related to your change.
> 

Do you want this to be in a separate series or for this patch series?

> >  
> >  /*
> >   * Allocate new trace_probe and initialize it (including fprobe).
> > @@ -605,10 +711,16 @@ static struct trace_fprobe *find_trace_fprobe(const char *event,
> >  	struct dyn_event *pos;
> >  	struct trace_fprobe *tf;
> >  
> > -	for_each_trace_fprobe(tf, pos)
> > +	list_for_each_entry(pos, &dyn_event_list, list) {
> > +		tf = trace_fprobe_from_dyn(pos);
> > +		if (!tf)
> > +			continue;
> > +
> >  		if (strcmp(trace_probe_name(&tf->tp), event) == 0 &&
> >  		    strcmp(trace_probe_group_name(&tf->tp), group) == 0)
> >  			return tf;
> > +	}
> > +
> 
> Ditto and there is no need to change.
> 

Ok. I will revert those sites to the existing macro-based iteration.

> >  	return NULL;
> >  }
> >  
> > @@ -835,7 +947,12 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
> >  	if (trace_fprobe_is_tracepoint(tf))
> >  		return __regsiter_tracepoint_fprobe(tf);
> >  
> > -	/* TODO: handle filter, nofilter or symbol list */
> > +	/* Registration path:
> > +	 *  - list_mode: pass filter/nofilter
> > +	 *  - single: pass symbol only (legacy)
> > +	 */
> > +	if (tf->list_mode)
> > +		return register_fprobe(&tf->fp, tf->filter, tf->nofilter);
> >  	return register_fprobe(&tf->fp, tf->symbol, NULL);
> >  }
> >  
> > @@ -1114,7 +1231,11 @@ static int __tprobe_event_module_cb(struct notifier_block *self,
> >  		return NOTIFY_DONE;
> >  
> >  	mutex_lock(&event_mutex);
> > -	for_each_trace_fprobe(tf, pos) {
> > +	list_for_each_entry(pos, &dyn_event_list, list) {
> > +		tf = trace_fprobe_from_dyn(pos);
> > +		if (!tf)
> > +			continue;
> > +
> >  		/* Skip fprobe and disabled tprobe events. */
> >  		if (!trace_fprobe_is_tracepoint(tf) || !tf->tuser)
> >  			continue;
> > @@ -1155,55 +1276,35 @@ static int parse_symbol_and_return(int argc, const char *argv[],
> >  				   char **symbol, bool *is_return,
> >  				   bool is_tracepoint)
> >  {
> > -	char *tmp = strchr(argv[1], '%');
> > -	int i;
> > -
> > -	if (tmp) {
> > -		int len = tmp - argv[1];
> > -
> > -		if (!is_tracepoint && !strcmp(tmp, "%return")) {
> > -			*is_return = true;
> > -		} else {
> > -			trace_probe_log_err(len, BAD_ADDR_SUFFIX);
> > -			return -EINVAL;
> > -		}
> > -		*symbol = kmemdup_nul(argv[1], len, GFP_KERNEL);
> > -	} else
> > -		*symbol = kstrdup(argv[1], GFP_KERNEL);
> > -	if (!*symbol)
> > -		return -ENOMEM;
> > -
> > -	if (*is_return)
> > -		return 0;
> > +	int i, ret;
> > +	bool list_mode = false;
> > +	char *filter = NULL; *nofilter = NULL;
> 
> Sort it as other functions. longer line to shorter.
> 

I did not know this. I will fix the ordering (and see next item about
the function's role).

> >  
> > -	if (is_tracepoint) {
> > -		tmp = *symbol;
> > -		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
> > -			tmp++;
> > -		if (*tmp) {
> > -			/* find a wrong character. */
> > -			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
> > -			kfree(*symbol);
> > -			*symbol = NULL;
> > -			return -EINVAL;
> > -		}
> > -	}
> > +	ret = parse_fprobe_spec(argv[1], is_tracepoint, symbol, is_return,
> > +			&list_mode, &filter, &nofilter);
> > +	if (ret)
> > +		return ret;
> >  
> > -	/* If there is $retval, this should be a return fprobe. */
> >  	for (i = 2; i < argc; i++) {
> > -		tmp = strstr(argv[i], "$retval");
> > +		char *tmp = strstr(argv[i], "$retval");
> > +
> >  		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
> >  			if (is_tracepoint) {
> >  				trace_probe_log_set_index(i);
> >  				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
> >  				kfree(*symbol);
> >  				*symbol = NULL;
> > +				kfree(filter);
> > +				kfree(nofilter);
> >  				return -EINVAL;
> >  			}
> >  			*is_return = true;
> >  			break;
> >  		}
> >  	}
> > +
> > +	kfree(filter);
> > +	kfree(nofilter);
> >  	return 0;
> >  }
> >  
> > @@ -1247,6 +1348,11 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  	int i, new_argc = 0, ret = 0;
> >  	bool is_tracepoint = false;
> >  	bool is_return = false;
> > +	bool list_mode = false;
> > +
> 
> Do not split local variable definitions with empty lines.
> 

I will collapse those blocks.

> > +	char *parsed_filter __free(kfree) = NULL;
> > +	char *parsed_nofilter __free(kfree) = NULL;
> > +	bool has_wild = false;
> 
> Please sort.
> 

I will sort and group them, so no empty line splits.

> >  
> >  	if ((argv[0][0] != 'f' && argv[0][0] != 't') || argc < 2)
> >  		return -ECANCELED;
> > @@ -1267,8 +1373,9 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  
> >  	trace_probe_log_set_index(1);
> >  
> > -	/* a symbol(or tracepoint) must be specified */
> > -	ret = parse_symbol_and_return(argc, argv, &symbol, &is_return, is_tracepoint);
> > +	/* Parse spec early (single vs list, suffix, base symbol) */
> > +	ret = parse_fprobe_spec(argv[1], is_tracepoint, &symbol, &is_return,
> > +			&list_mode, &parsed_filter, &parsed_nofilter);
> 
> Hmm, if so, where is the parse_symbol_and_return() called?
> I think you can pick the $retval search loop from the 
> parse_symbol_and_return() for updating is_return (or make
> it failure if is_tracepoint == true).
> 

Makes sense. I will fold the $retval scan into the new parser so there's
a single source of truth. $retval will remain rejected for tracepoints
with a proper error index. parse_symbol_and_return() can then be removed
or turned into a thin wrapper if still referenced.

> >  	if (ret < 0)
> >  		return -EINVAL;
> >  
> > @@ -1283,10 +1390,16 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  			return -EINVAL;
> >  	}
> >  
> > -	if (!event) {
> > -		ebuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> > -		if (!ebuf)
> > -			return -ENOMEM;
> > +		if (!event) {
> > +		/*
> > +		 * Event name rules:
> > +		 * - For list/wildcard: require explicit [GROUP/]EVENT
> > +		 * - For single literal: autogenerate symbol__entry/symbol__exit
> > +		 */
> 
> nit: to avoid confusing, comment should be indented as same as the
> code. Or, put the comment right before the `if`.
> 

I will move the comment above the if and align indentation. 

> > +			if (list_mode || has_wildcard(symbol)) {
> > +				trace_probe_log_err(0, NO_GROUP_NAME);
> > +			return -EINVAL;
> > +		}
> >  		/* Make a new event name */
> >  		if (is_tracepoint)
> >  			snprintf(ebuf, MAX_EVENT_NAME_LEN, "%s%s",
> > @@ -1319,7 +1432,8 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  							NULL, NULL, NULL, sbuf);
> >  		}
> >  	}
> > -	if (!ctx->funcname)
> > +
> > +	if (!list_mode && !has_wildcard(symbol) && !is_tracepoint)
> >  		ctx->funcname = symbol;
> >  
> >  	abuf = kmalloc(MAX_BTF_ARGS_LEN, GFP_KERNEL);
> > @@ -1353,6 +1467,21 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
> >  		return ret;
> >  	}
> >  
> > +	/* carry list parsing result into tf */
> > +	if (!is_tracepoint) {
> > +		tf->list_mode = list_mode;
> > +			if (parsed_filter) {
> > +				tf->filter = kstrdup(parsed_filter, GFP_KERNEL);
> > +				if (!tf->filter)
> > +					return -ENOMEM;
> > +			}
> > +			if (parsed_nofilter) {
> > +				tf->nofilter = kstrdup(parsed_nofilter, GFP_KERNEL);
> > +				if (!tf->nofilter)
> > +					return -ENOMEM;
> > +			}
> > +		}
> 
> Odd indentation. Please fix.
> 

My mistake. I will fix the indentation here.

> > +
> >  	/* parse arguments */
> >  	for (i = 0; i < argc; i++) {
> >  		trace_probe_log_set_index(i + 2);
> > @@ -1439,8 +1568,16 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
> >  	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
> >  				trace_probe_name(&tf->tp));
> >  
> > -	seq_printf(m, " %s%s", trace_fprobe_symbol(tf),
> > -			       trace_fprobe_is_return(tf) ? "%return" : "");
> > +	seq_printf(m, "%s", trace_fprobe_symbol(tf));
> > +	if (!trace_fprobe_is_tracepoint(tf)) {
> > +		if (tf->list_mode) {
> > +			if (trace_fprobe_is_return(tf))
> > +				seq_puts(m, ":exit");
> 
> In both cases, we can use ":exit" suffix. This means we will
> accept legacy "%return" for backward compatibility, but
> shows ":exit" always.
> 

I will make show always print :exit for return probes, regardless of the
input form, and never print %return.

> > +		} else {
> > +			if (trace_fprobe_is_return(tf))
> > +				seq_puts(m, "%return");
> > +		}
> > +	}
> >  
> >  	for (i = 0; i < tf->tp.nr_args; i++)
> >  		seq_printf(m, " %s=%s", tf->tp.args[i].name, tf->tp.args[i].comm);
> > -- 
> > 2.43.0
> > 
> 
> Thank you,
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

